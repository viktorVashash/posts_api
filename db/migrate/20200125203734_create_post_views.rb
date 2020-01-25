class CreatePostViews < ActiveRecord::Migration[5.2]
  def change
    create_table :post_views do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
  end
end
