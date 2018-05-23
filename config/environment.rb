# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SENDGRID_API_USER'],
  :password => ENV['SENDGRID_API_PASS'],
  :domain => 'cafeshares.com',
  :address => 'smtp.sendgrid.net',
  :port => '465',
  :authentication => :plain,
  :enable_starttls_auto => true
}
