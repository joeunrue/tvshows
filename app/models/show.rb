class Show < ActiveRecord::Base
  has_many :episodes
  attr_accessible :name

  scope :recent, lambda { |*args|
    number = args[0] || 5
    includes(:episodes => :torrents).
    joins(:episodes => :torrents).
    order('torrents.published_at DESC').
    limit(number)
  }
end
