class Johnhenry::SessionsController < Devise::SessionsController
  def new
    render 'johnhenry/devise/sessions/new'
  end
end
