class HomeController < ApplicationController
  def index
    @recent_episodes = Episode.recent(25)
  end
end
