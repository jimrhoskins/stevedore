class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action do
    response.headers["X-Docker-Registry-Version"] = '0.6.6'
  end

  def repo_full_name
    if params[:namespace].blank?
      params[:repo_name]
    else
      "#{params[:namespace]}/#{params[:repo_name]}"
    end.downcase
  end

  def set_token(token)
    response.headers["X-Docker-Token"] = token.to_s
  end

  def set_endpoints
    response.headers["X-Docker-Endpoints"] = request.host_with_port
  end
end
