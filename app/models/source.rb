class Source < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :collection_sources, dependent: :destroy
  enum rss_type: [:rss, :atom]
  validates_uniqueness_of :source

  after_create do |new_source|
    source_url = new_source.source
    URI.open(source_url) do |rss|
      feed = RSS::Parser.parse(rss, do_validate=false)
      generate_source(new_source, feed)
      generate_posts(new_source, feed)
    end
  end

  def self.refresh_all_sources()
    Source.all.each(&:refresh_posts)
  end

  def generate_source(new_source, feed)
    rss_type = new_source.rss_type
    case rss_type
    when 'atom'
      new_source.title ||= feed.title.content
      new_source.link ||= feed.link.href
    when 'rss'
      new_source.title ||= feed.channel.title
      new_source.link ||= feed.channel.link
    end
    new_source.save!
  end

  def generate_posts(source, feed, limit=100)
    source_id = source.id
    rss_type = source.rss_type
    feed.items[0..limit].each do |item|
      case rss_type
      when 'rss'
        link = item.link
        title = item.title
        author = item.author
        post_timestamp = item.pubDate
      when 'atom'
        link = item.link.href
        title = item.title.content
        author = item.author.name.content rescue nil
        post_timestamp = item.published.content rescue item.updated_content rescue DateTime.now
      end
      source_id = source.id

      # ignore nil post_timestamps because we don't know if they're new
      if not post_timestamp
        return
      end

      # don't create extremely old posts since they'll probably never be seen
      earliest_post = Post.minimum(:post_timestamp)
      if earliest_post == nil or post_timestamp >= earliest_post
        Post.find_or_create_by(link: link) do |post|
          post.title = title
          post.author = author
          post.source_id = source.id
          post.post_timestamp = post_timestamp
        end
      end
    end
  end

  def refresh_posts()
    source_url = self.source
    URI.open(source_url) do |rss|
      puts source_url
      feed = RSS::Parser.parse(rss, do_validate=false)
      generate_posts(self, feed)
    end
  end

  def get_posts(limit)
    Post.where(source_id: self.id).order('post_timestamp desc').limit(limit)
  end

end
