class HomeController < ApplicationController
  def index
    @recent_shows = Show.recent
    @recent_episodes = Episode.recent
  end
end
