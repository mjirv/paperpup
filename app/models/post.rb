class Post < ApplicationRecord
  belongs_to :source

  def get_attrs_to_show
    {
      id: self.id,
      title: self.title,
      post_timestamp: self.post_timestamp ? self.post_timestamp.to_date : '0001-01-01',
      author: self.author || '',
      source_title: self.source.title,
      link: self.link,
      source_color: self.source.color
    }
  end
end
