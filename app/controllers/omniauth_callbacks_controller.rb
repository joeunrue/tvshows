class OmniauthCallbacksController < ApplicationController
  def all
    oauth_account = OauthAccount.from_omniauth(request.env['omniauth.auth'])
    user = oauth_account.user || User.from_oauth_account(oauth_account)

    if user.persisted?
      flash.notice = 'Signed in!'
      sign_in_and_redirect user
    else
      redirect_to root_path
    end
  end
  alias_method :dropbox, :all
end
