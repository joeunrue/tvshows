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

  def file_formats
    episodes.includes(:torrents).map{ |episode|
      episode.torrents.map{ |i| i.file_format }
    }.flatten.uniq
  end

  def self.file_formats
    Show.includes(:episodes => :torrents).map{ |i|
      i.file_formats
    }.flatten.uniq
  end
end
