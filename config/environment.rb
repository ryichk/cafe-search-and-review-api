# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
ActionMailer::Base.smtp_settings = {
  :user_name => '#{Rails.application.secrets.sendgrind_api_user}',
  :password => '#{Rails.application.secrets.sendgrind_api_pass}',
  :domain => 'cafeshares.com',
  :address => 'smtp.sendgrid.net',
  :port => '465',
  :authentication => :plain,
  :enable_starttls_auto => true
}
