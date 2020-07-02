class PostsController < ApplicationController
  def index
    source_id = params[:source_id] || CollectionSource.where(collection_id: params[:collection_id]).select(:source_id).distinct.pluck(:source_id)
    start_time = params[:start_time] || -Float::INFINITY
    @posts = Post.where(source_id: source_id)
      .where.not(post_timestamp: nil)
      .where(post_timestamp: start_time...Float::INFINITY)
      .order('post_timestamp desc')
      .limit(params[:limit])
      .map(&:get_attrs_to_show)
    render json: @posts
  end

  def show
    id = params[:id]
    @post = Post.find(id)
    render json: @post.get_attrs_to_show
  end
end
