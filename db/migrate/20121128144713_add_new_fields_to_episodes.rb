class AddNewFieldsToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :published_at, :datetime
    add_column :episodes, :show_id, :integer
  end
end
