class AddSeasonAndEpisodeNumbersToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :season_number, :integer
    add_column :episodes, :episode_number, :integer
  end
end
