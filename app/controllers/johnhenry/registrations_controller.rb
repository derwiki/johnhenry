class Johnhenry::RegistrationsController < Devise::RegistrationsController
  before_filter :maybe_generate_password, only: [:create]
  before_filter :noop_test_at_test_dot_com, only: [:create]

  def new
    render 'johnhenry/devise/registrations/new'
  end

  private

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
