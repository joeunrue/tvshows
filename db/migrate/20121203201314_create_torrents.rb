class CreateTorrents < ActiveRecord::Migration
  def change
    create_table :torrents do |t|
      t.integer :episode_id
      t.datetime :published_at
      t.string :file
      t.boolean :is_nuked
      t.boolean :is_full_season
      t.string :filename
      t.string :file_format
      t.string :guid
      t.text :description

      t.timestamps
    end

    add_index :torrents, :episode_id
  end
end
