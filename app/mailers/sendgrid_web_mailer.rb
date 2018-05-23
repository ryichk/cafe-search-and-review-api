class SendgridWebMailer < ActionMailer::Base
  include Sendgrid

  def initialize
    @client = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY']).client
  end

  def send_some_email(record, token)
    mail = Mail.new
    # do your mail setup here
    mail = Mail.new
    mail.from = Email.new(email: cafeshares.com)
    mail.subject = YOUR_SUBJECT

    # I personally use sendgrid templates, but if you would like to use html -
    content = Content.new(
      type: 'text/html',
      value: ApplicationController.render(
        template: PATH_TO_TEMPLATE,
        layout: nil,
        assigns: IF_NEEDED || {}
      )
    )
    mail.contents = content

    personalization = Personalization.new
    personalization.to = Email.new(email: EMAIL, name: NAME)
    personalization.subject = SUBJECT

    mail.personalizations = personalization
    @client.mail._('send').post(request_body: mail.to_json)
  end
end
