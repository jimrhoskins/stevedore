class V1::TagsController < V1::RegistryController
  before_action :get_repo

  def index
    data = {}
    @repo.tags.all.each do |t|
      data[t.name] = t.value
    end

    render status: 200, json: data
  end

  def update
    tag = @repo.tags.find_or_create_by(name: params[:tag_name])
    tag.update_attributes! value: params[:_json]
    render status: 200, nothing: true
  end

  def get_repo
    @repo = Repository.find_by name: repo_full_name
  end


end
