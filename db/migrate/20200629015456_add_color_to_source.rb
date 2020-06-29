class AddColorToSource < ActiveRecord::Migration[6.0]
  def change
    add_column :sources, :color, :string
  end
end
