class Source < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :collection_sources, dependent: :destroy
  enum rss_type: [:rss, :atom]

  after_create do |new_source|
    source_url = new_source.source
    URI.open(source_url) do |rss|
      feed = RSS::Parser.parse(rss)
      rss_type = new_source.rss_type
      case rss_type
      when 'atom'
        new_source.title = feed.title.content
        new_source.link = feed.link.href
      when 'rss'
        new_source.title = feed.channel.title
        new_source.link = feed.channel.link
      end
      new_source.save!
      generate_posts(new_source, feed)
    end
  end

  def generate_posts(source, feed)
    source_id = source.id
    rss_type = source.rss_type
    feed.items.reverse.each do |item|
      case rss_type
      when 'rss'
        link = item.link
        title = item.title
        author = item.author
        post_timestamp = item.pubDate
      when 'atom'
        link = item.link.href
        title = item.title.content
        text = item.content.content
        author = item.author.name.content
        post_timestamp = item.published.content || item.updated_content
      end
      source_id = source.id

      Post.find_or_create_by(link: link) do |post|
        post.title = title
        post.text = text
        post.author = author
        post.source_id = source.id
        post.post_timestamp = post_timestamp
      end
    end
  end

  def get_posts(limit)
    Post.where(source_id: self.id).order('post_timestamp desc').limit(limit)
  end

end
