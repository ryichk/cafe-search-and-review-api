class MyDeviseMailer < Devise::Mailer
   helper :application # gives access to all helpers defined within `application_helper`.
   include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`

   def reset_password_instructions(record, token, opts={})

      SendgridWebMailer.send_some_email(record, token).deliver_later
   end
end