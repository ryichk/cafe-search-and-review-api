# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
ActionMailer::Base.smtp_settings = {
  :address => 'smtp.sendgrind.net',
  :port => '587',
  :authentication => :plain,
  :user_name => ENV['MAILER_USER'],
  :password => ENV['MAILER_PASS'],
  :domain => 'cafeshares.com',
  :enable_starttls_auto => true
}
