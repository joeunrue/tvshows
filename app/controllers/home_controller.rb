class HomeController < ApplicationController
  def index
    @recent_episodes = Episode.recent(25)
    @file_formats = @recent_episodes.map{ |i|
      i.torrents.map{ |i| i.file_format }
    }.flatten.uniq
  end
end
