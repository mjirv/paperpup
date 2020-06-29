class AddPostTimestampToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :post_timestamp, :timestamp
  end
end
