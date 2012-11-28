class Episode < ActiveRecord::Base
  belongs_to :show
  mount_uploader :torrent, TorrentUploader

  before_save :download_torrent,
    :if => Proc.new { |episode| episode.torrent.blank? }

  attr_accessible :description, :guid, :link, :title, :published_at

private

  def download_torrent
    curl = Curl::Easy.perform(link)
    header = curl.header_str
    filename_header = header.split("\r\n")[3]
    filename = /filename="(.+)"/.match(filename_header)[1]
    filepath = "#{Rails.root}/tmp/#{filename}"
    File.open(filepath, 'w:ASCII-8BIT') do |file|
      file.write curl.body_str
    end

    self.torrent = File.open(filepath)
  end
end
