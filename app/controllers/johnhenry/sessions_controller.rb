class JohnHenry::SessionsController < Devise::SessionsController
  def new
    render 'rails4payment/devise/sessions/new'
  end
end
