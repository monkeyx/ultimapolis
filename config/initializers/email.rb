EMAIL_DEFAULT_FROM = "Ultimapolis <support@ultimapolis.com>"
EMAIL_DEFAULT_REPLY = "Ultimapolis <admin@ultimapolis.com>"

unless Rails.env.production?
	EMAIL_BASE_HOST = "localhost:3000"
else
	EMAIL_BASE_HOST = "ultimapolis.com"
end

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = Rails.env.production?
ActionMailer::Base.default_url_options[:host] = EMAIL_BASE_HOST
ActionMailer::Base.raise_delivery_errors = true

ActionMailer::Base.smtp_settings = {
  :address  => "smtp.mandrillapp.com",
  :port  => 587, 
  :user_name => "monkeyx@gmail.com",
  :password => "64aiT4zVxBR4hP9lmNGzfw",
  :domain  => "ultimapolis.com",
  :enable_starttls_auto => true
}