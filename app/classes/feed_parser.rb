require 'feedzirra'
class FeedParser
  def initialize(url)
    @feed = Feedzirra::Feed.fetch_and_parse(url)
    @entries = @feed.entries.map { |i| EntryParser.new(i) }
  end

  def self.parse(url)
    feed_parser = FeedParser.new(url)
    feed_parser.parse
  end

  def parse
    @entries.each do |entry|
      entry.parse
    end
  end
end
