class User < ActiveRecord::Base
  has_many :oauth_accounts
  has_many :subscriptions
  has_many :shows, :through => :subscriptions

  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username
  attr_accessor :provider

  validates_presence_of :username
  validates_uniqueness_of :username

  def password_required?
    super && (provider.blank? && oauth_accounts.empty?)
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def self.from_oauth_account(account)
    User.create do |user|
      user.username = account.name
      user.email = account.email
      user.provider = account.provider
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end
end
