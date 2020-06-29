class AddRssTypeToSource < ActiveRecord::Migration[6.0]
  def change
    add_column :sources, :rss_type, :integer
  end
end
