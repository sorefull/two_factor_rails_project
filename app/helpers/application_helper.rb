module ApplicationHelper
  def render_qr(user)
    RQRCode::QRCode.new(
      user.otp_provisioning_uri(
        "#{Rails.application.secrets.issuer}:#{user.email}",
        issuer: (issuer)
        )
      ).as_html
  end

  private

  def issuer
    'TwoFactorRailsProject'
  end
end
