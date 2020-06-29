class CreateCollectionSources < ActiveRecord::Migration[6.0]
  def change
    create_table :collection_sources do |t|
      t.integer :collection_id
      t.integer :source_id

      t.timestamps
    end
  end
end
