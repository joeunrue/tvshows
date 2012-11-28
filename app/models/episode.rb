class Episode < ActiveRecord::Base
  # Associations
  belongs_to :show
  mount_uploader :torrent, TorrentUploader

  # Callbacks
  before_create :parse_description
  before_save :download_torrent,
    :if => Proc.new { |episode| episode.torrent.blank? }

  attr_accessible :description, :guid, :link, :title, :published_at

  def parse_description
    description_array = description.split(';').map{|i| i.strip}
    parse_file_format(description_array[1])
    parse_season_number(description_array[2])
    parse_episode_number(description_array[3])
    parse_filename(description_array[4])
    true
  end

  def name
    description_array = description.split(';').map{|i| i.strip}
    parse_name description_array[1]
  end

private

  def parse_name(line)
    @name = /Show Title:([^\(\)]+)/.match(line)[1].strip
  end

  def parse_file_format(line)
    self.file_format = /Show Title:[^\(\)]+ \(([^\(\)]+)\)/.match(line)[1].strip
  end

  def parse_season_number(line)
    self.season_number = /Season: (\d+)/.match(line)[1].to_i
  end

  def parse_episode_number(line)
    self.episode_number = /Episode: (.+)/.match(line)[1].to_i
    self.is_full_season = true if self.episode_number == 0
  end

  def parse_filename(line)
    self.filename = /Filename:(.+)/.match(line)[1].strip
  end

  def download_torrent
    tmp_filepath = "#{Rails.root}/tmp/#{filename.gsub(/ /,'_')}.torrent"
    if !File.exists?(tmp_filepath)
      begin
        File.open(tmp_filepath, 'w:ASCII-8BIT') do |file|
          curl = Curl::Easy.perform(link)
          file.write curl.body_str
        end
      rescue
        return false
      end
    end
    self.torrent = File.open(tmp_filepath)
    true
  end
end
