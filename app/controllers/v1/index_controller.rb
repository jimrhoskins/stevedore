class V1::IndexController < ApplicationController
  skip_before_filter :verify_authenticity_token

  after_action :set_endpoints

end
