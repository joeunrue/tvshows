class AddTorrentToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :torrent, :string
  end
end
