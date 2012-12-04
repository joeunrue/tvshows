class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.integer :show_id
      t.string :title
      t.integer :season_number
      t.integer :episode_number

      t.timestamps
    end

    add_index :episodes, :show_id
    add_index :episodes, :season_number
  end
end
