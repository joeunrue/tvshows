class AddNameAndEmailToOauthAccounts < ActiveRecord::Migration
  def change
    add_column :oauth_accounts, :name, :string
    add_column :oauth_accounts, :email, :string
  end
end
