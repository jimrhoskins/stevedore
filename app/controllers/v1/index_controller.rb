class V1::IndexController < V1::ApiController
  skip_before_filter :verify_authenticity_token

  after_action :set_endpoints

end
