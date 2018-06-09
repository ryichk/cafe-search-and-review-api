class InquiryMailer < ApplicationMailer

  # 送信元アドレス
  default from: "smtp.sendgrid.net"
  # 送信先アドレス
  default to: "ryichikio@gmail.com"

  def sendmail_confirm(inquiry)
    @inquiry = inquiry
    # メール件名
    mail(:subject => 'Cafe Sharesの問い合わせフォームから問い合わせがありました。')
  end
end