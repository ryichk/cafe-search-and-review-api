class InquiryMailer < ActionMailer::Base

  # 送信元アドレス
  default from: "example@example.com"
  # 送信先アドレス
  default to: "ryichikio@gmail.com"

  def sendmail_confirm(inquiry)
    # メール件名
    mail_subject = "Cafe Shakerの問い合わせフォールから問い合わせがありました。"
    @inquiry = inquiry
    
  end
end