class Post < ApplicationRecord
  belongs_to :source

  def get_attrs_to_show
    {
      id: self.id,
      title: self.title,
      post_timestamp: self.post_timestamp.to_date,
      author: self.author || '',
      source_title: self.source.title
    }
  end
end
