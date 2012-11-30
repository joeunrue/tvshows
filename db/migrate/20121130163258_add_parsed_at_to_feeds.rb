class AddParsedAtToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :parsed_at, :datetime
  end
end
