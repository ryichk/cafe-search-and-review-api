class InquiryMailer < ApplicationMailer

  # # 送信元アドレス
  # default from: "cafeshares.com"
  # 送信先アドレス
  default to: "ryichikio@gmail.com"

  def sendmail_confirm(inquiry)
    @inquiry = inquiry
    # メール件名
    mail_subject = 'Cafe Sharesの問い合わせフォームから問い合わせがありました。'
    mail to: "ryichikio@gmail.com", subject: mail_subject
  end
end