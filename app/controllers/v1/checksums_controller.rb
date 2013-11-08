class V1::ChecksumsController < V1::RegistryController
  def update
    binding.pry
    checksum = request.headers["x-docker-checksum"]
    image = Image.find_by uid: params[:image_id]

    unless image
      return render status: 404, nothing: true
    end

    image.update_attributes!(checksum: checksum)
    binding.pry

    render status: 200, nothing: true
  end
end
