class InquiryMailer < ActionMailer::Base

  # 送信元アドレス
  default from: "cafeshares.com"

  # 送信先アドレス

  def sendmail_confirm(inquiry)
    mail to: "ryichikio@gmail.com",
         subject: "Cafe Sharesの問い合わせフォームから問い合わせがありました。"
    @inquiry = inquiry
  end
end