class CreateTorrents < ActiveRecord::Migration
  def change
    create_table :torrents do |t|
      t.integer :episode_id
      t.string :title
      t.string :link
      t.text :description
      t.string :guid
      t.datetime :published_at
      t.string :file
      t.boolean :is_nuked
      t.boolean :is_full_season
      t.string :filename
      t.string :file_format

      t.timestamps
    end

    add_index :torrents, :episode_id
  end
end
