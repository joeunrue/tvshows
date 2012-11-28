require 'feedzirra'
class Feed < ActiveRecord::Base
  attr_accessible :name, :url

  def parse_feed
    feed = Feedzirra::Feed.fetch_and_parse(url)
    feed.entries.each do |entry|
      show_title = Show.parse_title(entry.title)
      show = Show.find_or_create_by_name(show_title)
      if show.episodes.find_by_guid(entry.entry_id).nil?
        show.episodes.build(
          :title => entry.title,
          :link => entry.url,
          :guid => entry.entry_id,
          :description => entry.summary,
          :published_at => entry.published
        )
        show.save
      end
    end
  end
end
