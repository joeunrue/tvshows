class TorrentsController < ApplicationController
  load_and_authorize_resource

  def index
    @torrents = Torrent.all
  end

  def show
    @torrent = Torrent.find(params[:id])
  end

  def new
    @torrent = Torrent.new
  end

  def edit
    @torrent = Torrent.find(params[:id])
  end

  def create
    @torrent = Torrent.new(params[:torrent])

    if @torrent.save
      redirect_to @torrent, notice: 'Torrent was successfully created.'
    else
      render 'new'
    end
  end

  def update
    @torrent = Torrent.find(params[:id])

    if @torrent.update_attributes(params[:torrent])
      redirect_to @torrent, notice: 'Torrent was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @torrent = Torrent.find(params[:id])
    @torrent.destroy

    redirect_to torrents_url
  end
end
