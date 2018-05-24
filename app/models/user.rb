class User < ApplicationRecord
  devise :registerable, :rememberable, :trackable, :validatable

  devise :two_factor_authenticatable, :otp_secret_encryption_key => Rails.application.secrets.otp_key

  devise :two_factor_backupable, otp_backup_code_length: 32, otp_number_of_backup_codes: 10
  serialize :otp_backup_codes, Array

  after_create :generate_two_factor_secrets!

  private

  def generate_two_factor_secrets!
    self.otp_secret = User.generate_otp_secret
    # This codes must be sent to user at that point, no way to get them again
    codes = self.generate_otp_backup_codes!
    self.save!
  end
end
