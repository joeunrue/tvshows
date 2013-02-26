class FeedsController < ApplicationController
  load_and_authorize_resource

  def index
    @feeds = Feed.all
  end

  def show
    @feed = Feed.find(params[:id])
  end

  def new
    @feed = Feed.new
  end

  def edit
    @feed = Feed.find(params[:id])
  end

  def create
    @feed = Feed.new(params[:feed])

    if @feed.save
      redirect_to @feed, notice: 'Feed was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @feed = Feed.find(params[:id])

    if @feed.update_attributes(params[:feed])
      redirect_to @feed, notice: 'Feed was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy

    redirect_to feeds_url
  end
end
