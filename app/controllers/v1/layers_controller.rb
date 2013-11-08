class V1::LayersController < V1::RegistryController
  def update
    Layer.put(params[:image_id], request.body)
    render status: 200, nothing: true
  end

  def show
  end
end
