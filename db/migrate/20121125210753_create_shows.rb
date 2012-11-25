class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :title
      t.string :link
      t.string :guid
      t.text :description

      t.timestamps
    end
  end
end
