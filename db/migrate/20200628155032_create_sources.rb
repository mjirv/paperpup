class CreateSources < ActiveRecord::Migration[6.0]
  def change
    create_table :sources do |t|
      t.string :name
      t.string :author
      t.string :source
      t.string :link

      t.timestamps
    end
  end
end
