class AddTitleToSource < ActiveRecord::Migration[6.0]
  def change
    add_column :sources, :title, :string
  end
end
