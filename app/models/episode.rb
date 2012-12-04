class Episode < ActiveRecord::Base
  # Associations
  belongs_to :show
  has_many :torrents

  attr_accessible :title, :season_number, :episode_number

  def name
    title
  end
end
