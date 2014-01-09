require 'github/markup'

class Johnhenry::PaymentsController < Johnhenry::ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]
  before_filter :must_have_session, only: [:index, :show]

  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.where(user_id: current_user.id)
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
    filename = File.join(File.dirname(File.expand_path(__FILE__)),
                       '../../../README.md')
    @readme = GitHub::Markup.render(filename, File.read(filename))
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  def create
    if !signed_in?
      if params[:email].present?
        #TODO DRY with other new user generation
        password = Devise.friendly_token.first(10)
        user = JohnHenryUser.create! email: params[:email],
                                     password: password,
                                     password_confirmation: password
        sign_in(user)
      else
        return redirect_to '/', alert: 'You need an account to do that.'
      end
    end

    begin
      charge_user!(payment_params['stripe_token'], 7)
    rescue => exc
      Rails.logger.error(exc.message)
      Rails.logger.error(exc.inspect)
      return redirect_to '/', alert: 'Payment could not be processed.'
    end

    txn_info = {
      user_id: current_user.id,
      stripe_customer_id: current_user.stripe_customer_id,
      amount: 7.0
    }
    @payment = Payment.new(payment_params.merge(txn_info))

    respond_to do |format|
      if @payment.save
        format.html { redirect_to @payment, notice: 'Payment was successfully made.' }
        format.json { render action: 'show', status: :created, location: @payment }
      else
        format.html { render action: 'new' }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  def charge_user!(stripe_token, amount)
    Rails.logger.info "Charging #{ current_user.id } : _stripe_token: #{ stripe_token }"

    # create customer_id if it's a new stripe_token
    unless current_user.stripe_customer_id
      customer = Stripe::Customer.create(
        card: stripe_token,
        description: current_user.email || "user_id_#{ current_user.id }"
      )
      Rails.logger.info "Created customer: #{ customer.inspect }"
      current_user.update_attributes stripe_customer_id: customer.id
    end

    Rails.logger.info(
      "About to charge customer_id: #{ current_user.stripe_customer_id }")
    charge = Stripe::Charge.create(
      amount: amount * 100, # convert from dollars to cents
      currency: 'usd',
      customer: current_user.stripe_customer_id
    )
    Rails.logger.info "Charged #{ charge.inspect }"
  end


  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
      if !allowed_user?(@payment)
        flash[:alert] = "You don't have permission to see that payment."
        return redirect_to '/'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:user_id, :stripe_token, :stripe_customer_id, :email)
    end

    def allowed_user?(payment)
      return false unless signed_in?
      (admin_ids + [payment.user_id]).compact.include?(current_user.try(:id))
    end

    def must_have_session
      if !signed_in?
        flash[:alert] = "You need an account to view your payments."
        return redirect_to '/'
      end
    end
end
