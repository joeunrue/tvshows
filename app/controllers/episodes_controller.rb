class EpisodesController < ApplicationController
  before_filter :find_show

  def index
    @episodes = @show.episodes.sorted
    @file_formats = @episodes.map{
      |i| i.torrents.map{ |i| i.file_format }
    }.flatten.uniq
  end

  def show
    @episode = @show.episodes.find(params[:id])
  end

  def new
    @episode = @show.episodes.new
  end

  def edit
    @episode = @show.episodes.find(params[:id])
  end

  def create
    @episode = @show.episodes.new(params[:episode])

    if @episode.save
      redirect_to [@show, @episode], notice: 'Episode was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @episode = @show.episodes.find(params[:id])

    if @episode.update_attributes(params[:episode])
      redirect_to [@show, @episode], notice: 'Episode was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @episode = @show.episodes.find(params[:id])
    @episode.destroy

    redirect_to show_episodes_url(@show)
  end

private

  def find_show
    @show = Show.find(params[:show_id])
  end
end
