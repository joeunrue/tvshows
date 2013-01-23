class Subscription < ActiveRecord::Base
  belongs_to :show
  belongs_to :user
  attr_accessible :file_format_string, :ignore_seasons, :show_id, :user_id
end
