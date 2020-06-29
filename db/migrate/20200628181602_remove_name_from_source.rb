class RemoveNameFromSource < ActiveRecord::Migration[6.0]
  def change
    remove_column :sources, :name, :string
  end
end
