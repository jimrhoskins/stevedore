class V1::ImagesController < V1::IndexController
  def update
    repo = Repository.put(repo_full_name, params[:_json])
    render status: 204, nothing: true
  end

  def show
    repo = Repository.find_by(name: repo_full_name)
    unless repo
      return render status: 404, nothing: true
    end

    data = repo.repository_images.map do |repo_image|
      {
        "id" => repo_image.image.uid,
        "checksum" => repo_image.image.checksum,
        "Tag" => repo_image.tag
      }
    end

    render status: 200, json: data
  end



  def ancestry
    image = Image.find_by uid: params[:image_id]

    ids = []

    while image
      ids.push image.uid
      image = image.parent
    end

    render status: 200, json: ids

  end
end
