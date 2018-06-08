class InquiryMailer < ActionMailer::Base

  # 送信元アドレス
  default from: "sendgrid.net"
  # 送信先アドレス
  default to: "ryichikio@gmail.com"

  def sendmail_confirm(inquiry)
    # メール件名
    mail_subject = "Cafe Sharesの問い合わせフォールから問い合わせがありました。"
    @inquiry = inquiry
    
  end
end