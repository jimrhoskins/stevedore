class V1::ImageJsonController < V1::RegistryController

  # Put image data for given :image_id
  #
  # params[:image_json] => {...JSON DATA...}
  def update
    image = Image.find_by uid: params[:image_id]
    unless image
      return render status: 404, nothing: true
    end

    image.set_json params[:image_json]

    render status: 200, nothing: true
  end

  def show
    image = Image.find_by uid: params[:image_id]
    unless image
      return render status: 404, nothing: true
    end

    begin 
      json = JSON.parse(image.json)
    rescue
      return render status: 404, nothing: true
    end


    response.headers["X-Docker-Size"] = image.size.to_s
    response.headers["X-Docker-Checksum"] = image.checksum if image.checksum
    render status: 200, json: json
  end


end
