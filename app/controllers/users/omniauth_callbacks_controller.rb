class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # def facebook
  #   # You need to implement the method below in your model (e.g. app/models/user.rb)
  #   @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

  #   if @user.persisted?
  #     set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
  #     sign_in_and_redirect @user, :event => :authentication
  #   else
  #     session["devise.facebook_data"] = request.env["omniauth.auth"]
  #     redirect_to new_user_registration_url
  #   end
  # end

  # def twitter
  #   # You need to implement the method  below in your model
  #   @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

  #   if @user.persisted?
  #     set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
  #     sign_in_and_redirect @user, :event => :authentication
  #   else
  #     session["devise.twitter_data"] = request.env["omniauth.auth"].except("extra")
  #     redirect_to new_user_registration_url
  #   end
  # end
  def facebook
    callback_from :facebook
  end

  def twitter
    callback_from :twitter
  end

  def instagram
    callback_from :instagram
  end


    private
      def callback_from(provider)
        provider = provider.to_s
        if provider == "facebook"
          @user = User.find_for_facebook_oauth(request.env['omniauth.auth'])
          if @user.persisted? #保存済みかどうかを確認
            flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
            sign_in_and_redirect @user, event: :authentication
          else
            session["devise.#{provider}_data"] = request.env['omniauth.auth']
            redirect_to new_user_registration_url
          end
        elsif provider == "twitter"
          @user = User.find_for_twitter_oauth(request.env['omniauth.auth'])
          if @user.persisted? #保存済みかどうかを確認
            flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
            sign_in_and_redirect @user, event: :authentication
          else
            session["devise.#{provider}_data"] = request.env['omniauth.auth']
            redirect_to new_user_registration_url
          end
        elsif provider == "instagram"
          @user = User.find_for_instagram_oauth(request.env['omniauth.auth'])
          if @user.persisted? #保存済みかどうかを確認
            flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
            sign_in_and_redirect @user, event: :authentication
          else
            session["devise.#{provider}_data"] = request.env['omniauth.auth']
            redirect_to new_user_registration_url
          end
        end
    end

      def user_params
        request.env["omniauth.auth"].slice(:provider, :uid).to_h
      end
end
