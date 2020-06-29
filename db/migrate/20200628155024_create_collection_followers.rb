class CreateCollectionFollowers < ActiveRecord::Migration[6.0]
  def change
    create_table :collection_followers do |t|
      t.integer :collection_id
      t.integer :user_id

      t.timestamps
    end
  end
end
