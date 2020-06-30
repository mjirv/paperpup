class SourcesController < ApplicationController
  def index
    @sources = Source.all.order(:title)
    render json: @sources
  end

  def show
    @source = Source.find(params[:id])
    @posts = @source.get_posts(limit=params[:limit_posts])
    render json: {source: @source, posts: @posts}
  end
end
