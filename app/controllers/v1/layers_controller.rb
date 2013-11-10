class V1::LayersController < V1::RegistryController
  include ActionController::Live


  def update
    Layer.put(params[:image_id], request.body)

    response.stream.close
  end

  def show
    head = Layer.head(params[:image_id])
    if head
      response.header['Content-Size'] = head.content_length.to_s

      Layer.get(params[:image_id]) do |chunk|
        response.stream.write chunk
        true
      end

      response.stream.close
    else
      render status: 404, nothing: true
    end
  end
end
