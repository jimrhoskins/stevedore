class V1::RepositoriesController < V1::IndexController
  # Create a repository at [:namespace/]:repo_name
  #
  # params[:_json] => [
  #   {"id" => "image_id_sha", "Tag" => "latest"},
  #   {"id" => "image_id_sha", "Tag" => "latest"},
  #   ...
  # ]
  #
  # Sets Docker Token
  # Sets Docker Endpoints
  #
  # 200 [sic] - Created 
  # 400 - Errors
  # 401 - Unauthorized
  # 403 - Account Not Active
  #
  # No Body
  def create
    repo = Repository.put(repo_full_name, params[:_json])
    token = current_user.tokens.create( access: "write")
    set_token(token)
    set_endpoints
    render status: 200, nothing: true
  end


  protected

end
