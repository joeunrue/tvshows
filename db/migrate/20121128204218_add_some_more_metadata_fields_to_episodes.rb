class AddSomeMoreMetadataFieldsToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :file_format, :string
    add_column :episodes, :is_nuked, :boolean
    add_column :episodes, :is_full_season, :boolean
    add_column :episodes, :filename, :string
  end
end
