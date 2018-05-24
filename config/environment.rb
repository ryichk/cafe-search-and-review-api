# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
ActionMailer::Base.smtp_settings = {
  :user_name => Rails.application.secrets.SENDGRID_API_USER,
  :password => Rails.application.secrets.SENDGRID_API_PASS,
  :domain => 'cafeshares.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
