class V1::ImageJsonController < V1::RegistryController

  # Put image data for given :image_id
  #
  # params[:image_json] => {...JSON DATA...}
  def update
    token = load_token
    unless token
      return render status: 401, nothing: true
    end

    image = token.repository.images.find_by uid: params[:image_id]
    unless image
      return render status: 404, nothing: true
    end

    unless token.access == "write"
      return render status: 401, nothing: true
    end

    image.set_json params[:image_json]

    render status: 200, nothing: true
  end

  def show
    #token = load_token
    #unless token
      #return render status: 401, nothing: true
    #end

    #image = token.repository.images.find_by uid: params[:image_id]
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


  def load_token
    token_sig = request.headers[:authorization].match(/signature=([0-9a-z]+)/)[1]
    return nil unless token_sig

    token = Token.find_by(signature: token_sig)
  end

  def verify_token(access, image)
    token_sig = request.headers[:authorization].match(/signature=([0-9a-z]+)/)[1]
    return false unless token_sig

    token = Token.find_by(signature: token_sig)
    return false unless token

    (access == "read" || token.access == access) && token.repository_id == image.repository_id
  end
end
