require 'feedzirra'
class Feed < ActiveRecord::Base
  attr_accessible :name, :url

  def parse_feed
    feed = Feedzirra::Feed.fetch_and_parse(url)
    feed.entries.each do |entry|
      Show.get_name_from_episode_title(entry.title)
    end
  end
end
