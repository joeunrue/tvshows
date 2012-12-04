class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :name
      t.string :url
      t.datetime :parsed_at

      t.timestamps
    end
  end
end
