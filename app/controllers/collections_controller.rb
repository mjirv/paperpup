class CollectionsController < ApplicationController
  def index
    @collections = Collection.all
    render json: @collections
  end

  def show
    @collection = Collection.find(params[:id])
    @sources = @collection.get_sources()
    render json: {collection: @collection, sources: @sources}
  end
end
