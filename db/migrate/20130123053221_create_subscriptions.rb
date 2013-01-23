class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :show_id
      t.integer :user_id
      t.string :file_format_string

      t.timestamps
    end
  end
end
