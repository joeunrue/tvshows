class Show < ActiveRecord::Base
  has_many :episodes
  has_many :subscriptions
  has_many :users, :through => :subscriptions
  attr_accessible :name

  scope :recent, lambda { |*args|
    number = args[0] || 5
    includes(:episodes => :torrents).
    order('episodes.created_at DESC').
    limit(number)
  }
end
