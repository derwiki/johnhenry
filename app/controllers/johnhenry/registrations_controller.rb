class Johnhenry::RegistrationsController < Devise::RegistrationsController
  before_filter :maybe_generate_password, only: [:create]
  before_filter :noop_test_at_test_dot_com, only: [:create]

  def new
    render 'johnhenry/devise/registrations/new'
  end

  def create
    super

    # tell the layout it can render a Google AdWords conversion event
    flash[:gaw_conversion] = :signup
  end

  private

    # redirect with a query param that can be used as a Google Analytics goal
    def after_sign_in_path_for(user)
      '/?signup=1'
    end

    def maybe_generate_password
      if params['user']['password'].blank? &&
         params['user']['password_confirmation'].blank?
        password = Devise.friendly_token.first(10)
        params['user']['password'] = password
        params['user']['password_confirmation'] = password
      end
    end

    def noop_test_at_test_dot_com
      if params['user']['email'] == 'test@test.com'
        flash[:notice] = 'Almost created account for test@test.com.'
        return redirect_to '/'
      end
    end
end 
