class JohnHenryUser < ActiveRecord::Base
  self.table_name = 'users'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create :send_signup_email, if: :john_henry_signup_email_enabled?

  def guess_name_from_email
    s = email.split('@').first.try(:titleize)
    s.split(/[.+-]/).first
  end

  private

    def send_signup_email
      JohnHenryMailer.signup(self).deliver
    end

    def john_henry_signup_email_enabled?
      Rails.application.config.respond_to?('send_johnhenry_signup_email') &&
        Rails.application.config.send_johnhenry_signup_email
    end
end
