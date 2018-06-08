class InquiryController < ApplicationController

  # 問い合わせフォーム画面を表示
  def index
    @inquiry = Inquiry.new
    render :action => 'index'
  end

  # 問い合わせフォームから入力された内容をチェックする
  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.valid?
      # 入力内容に問題が無い場合、問い合わせ確認画面を表示
      render :action => 'confirm'
    else
      # 入力内容に問題がある場合、問い合わせ画面を再表示
      render :action => 'index'
    end
  end

  # 問い合わせ完了画面の処理
  def thanks
    # 問い合わせ内容をChatWorkへ通知
    @inquiry = Inquiry.new(inquiry_params)
    @mail = InquiryMailer.sendmail_confirm(@inquiry).deliver_now

    # 問い合わせ完了画面を表示する
    render :action => 'thanks'
  end

  # Strong Parameters で問い合わせ画面からの入力を許可するリクエストパラメータを指定する
  def inquiry_params
    params.require(:inquiry).permit(
      :name, :email, :phone, :message
      )
  end
end
