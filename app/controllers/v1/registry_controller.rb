class V1::RegistryController < V1::ApiController
  skip_before_filter :verify_authenticity_token

  def ping
    render nothing: true
  end
end
