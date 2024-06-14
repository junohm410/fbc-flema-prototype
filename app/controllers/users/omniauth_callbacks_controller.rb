class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def discord
    @user = User.find_or_create_from_auth_hash!(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in @user
      redirect_to items_path, notice: I18n.t('devise.omniauth_callbacks.success', kind: 'Discord')
    else
      session['devise.discord_data'] = request.env['omniauth.auth'].except('extra')
      redirect_to root_path, alert: @user.errors.full_messages.join("\n")
    end
  end
end
