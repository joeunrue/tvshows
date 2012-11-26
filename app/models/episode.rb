class Episode < ActiveRecord::Base
  belongs_to :show
  mount_uploader :torrent, TorrentUploader

  attr_accessible :description, :guid, :link, :title
end
