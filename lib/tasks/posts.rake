namespace :posts do
  desc "Deletes old posts to keep database in Heroku free tier limit (10k)"
  task delete_old: :environment do
    num_to_delete = Post.count - 9000
    if num_to_delete > 0
      Post.order(:post_timestamp).limit(num_to_delete).map(&:destroy)
    end
  end
end
