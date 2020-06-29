class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :author
      t.integer :source_id
      t.text :text

      t.timestamps
    end
  end
end
