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

  def create
    safe_params = params.require(:source).permit(:title, :source, :color, :rss_type)
    puts safe_params
    @source = Source.create(
      source: safe_params[:source],
      title: safe_params[:title],
      color: safe_params[:color],
      rss_type: safe_params[:rss_type]
    )
  end
end
