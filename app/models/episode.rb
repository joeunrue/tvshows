class Episode < ActiveRecord::Base
  # Associations
  belongs_to :show
  has_many :torrents

  attr_accessible :title, :season_number, :episode_number

  scope :sorted, order(:season_number, :episode_number)
  scope :recent, lambda { |*args|
    number = args[0] || 5
    includes(:torrents, :show).
    order('episodes.created_at DESC').
    limit(number)
  }

  def name
    title
  end

  def published_at
    torrents.order(:published_at).first.published_at
  end
end
