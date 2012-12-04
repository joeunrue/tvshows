class Feed < ActiveRecord::Base

  attr_accessible :name, :url
  validates_presence_of :name, :url

  DEFAULT_DOWNLOAD_INTERVAL_IN_DAYS = 1

  def self.parse_all
    Feed.all.each{ |feed| feed.parse_feed }
  end

  def parse_feed
    FeedParser.parse(url_with_days)
    update_attribute(:parsed_at, Time.now)
  end

  def url_with_days(days = DEFAULT_DOWNLOAD_INTERVAL_IN_DAYS)
    self.url + "&interval=#{days}+days"
  end

private

  def feed_from_feedzirra
    Feedzirra::Feed.fetch_and_parse(url)
  end

end
