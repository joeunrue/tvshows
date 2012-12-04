class Show < ActiveRecord::Base
  has_many :episodes
  attr_accessible :name
end
