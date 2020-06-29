class CreateCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :collections do |t|
      t.integer :user_id
      t.string :name
      t.string :description
      t.boolean :is_public

      t.timestamps
    end
  end
end
