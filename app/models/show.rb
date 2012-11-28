class Show < ActiveRecord::Base
  has_many :episodes
  attr_accessible :name

  def self.parse_title(title)
    title.split(' - ').first
  end
end
