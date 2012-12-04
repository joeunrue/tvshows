class Torrent < ActiveRecord::Base
  # Associations
  belongs_to :episode
  mount_uploader :file, FileUploader

  # Callbacks
  after_save :download_file

  attr_accessible :episode_id, :file, :file_format, :filename, :link, :title,
    :is_full_season, :is_nuked, :description, :guid, :published_at

  def download_file
    if self.file.blank?
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
      update_attribute(:file, File.open(tmp_filepath))
      File.delete(tmp_filepath)
    end
    true
  end
end
