class User < ApplicationRecord
  devise :registerable, :rememberable, :trackable, :validatable,
         :two_factor_authenticatable,
         :otp_secret_encryption_key => Rails.application.secrets.otp_key

  after_create :generate_otp_secret!

  private

  def generate_otp_secret!
    self.otp_secret = User.generate_otp_secret
    self.save!
  end
end
