class InquiryMailer < ActionMailer::Base

  # 送信元アドレス
  default from: "cafeshares.com"
  # 送信先アドレス
  default to: "ryichikio@gmail.com"

  def sendmail_confirm(inquiry)
    @inquiry = inquiry
    # メール件名
    mail_subject = 'Cafe Sharesの問い合わせフォームから問い合わせがありました。'
    mail(:subject => mail_subject)
  end
end