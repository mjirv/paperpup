class CollectionsController < ApplicationController
  def index
    @collections = Collection.order(:created_at).limit(params[:limit])
    render json: @collections
  end

  def show
    @collection = Collection.find(params[:id])
    @sources = @collection.get_sources()
    render json: {collection: @collection, sources: @sources}
  end

  def create
    safe_params = params.require(:collection).permit([:name, :description, :source_ids])
    params[:collection].each do |k, v|
      if v.blank?
        response = { "error" => "not all fields filled out" }
        render json: response, status: :bad_request
        return
      end
    end
    @collection = Collection.new(safe_params)
    @collection.save!
    @collection.add_source(params[:collection][:source_ids])
    render json: {id: @collection.id}
  end
end
