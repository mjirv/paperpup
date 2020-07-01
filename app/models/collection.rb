class Collection < ApplicationRecord
  has_many :collection_sources, dependent: :destroy
  validates_uniqueness_of :name

  def get_sources()
    self.collection_sources.flat_map(&:source)
  end

  def add_source(source_ids)
    source_ids.each do |source_id|
      CollectionSource.find_or_create_by(
        source_id: source_id, collection_id: self.id
      )
    end
  end
end
