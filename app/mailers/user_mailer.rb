class UserMailer < ActionMailer::Base
  default from: 'No Reply <no-reply@example.com>'
  default bcc: ENV['BCC_EMAILS'] if ENV['BCC_EMAILS'].present?

  def signup(user)
    @user = user
    @name = @user.email.split('@').first.try(:titleize)
    subject = "Thanks for trying the JohnHenry Rails toolkit"
    subject += ", #{ @name }" unless @name.blank?
    Rails.logger.info "Sending signup notification to #{ user.email }"
    mail to: user.email,
         subject: subject
  end
end
