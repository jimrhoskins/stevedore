class V1::RegistryController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def ping
    render nothing: true
  end
end
