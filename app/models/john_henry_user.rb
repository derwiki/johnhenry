class JohnHenryUser < ActiveRecord::Base
  self.table_name = 'users'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_save :send_signup_email

  private

    def send_signup_email
      JohnHenryMailer.signup(self).deliver
    end
end
