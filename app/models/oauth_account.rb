class OauthAccount < ActiveRecord::Base
  belongs_to :user
  attr_accessible :provider, :secret, :token, :uid, :user_id

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |account|
      account.provider = auth.provider
      account.uid = auth.uid
      case auth.provider
      when 'dropbox'
        account.name = auth.info.name
        account.email = auth.info.email
        account.token = auth.credentials.token
        account.secret = auth.credentials.secret
      end
      account.user = User.from_oauth_account(account)
    end
  end
end
