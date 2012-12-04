class Feed < ActiveRecord::Base

  attr_accessible :name, :url
  validates_presence_of :name, :url

  def self.parse_all
    Feed.all.each{ |feed| feed.parse_feed }
  end

  def parse_feed
    FeedParser.parse(self.url)
    update_attribute(:parsed_at, Time.now)
  end

private

  def feed_from_feedzirra
    Feedzirra::Feed.fetch_and_parse(url)
  end

end
