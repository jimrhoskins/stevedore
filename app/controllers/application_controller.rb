class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action do
    response.headers["X-Docker-Registry-Version"] = '0.6.6'
  end
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :require_user


   def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_up) << :username
   end

  def repo_full_name
    # The docker client will refer to top level repo foo as
    # both "foo" and "library/foo" depending on the request
    if params[:namespace].blank? || params[:namespace] == "library"
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

  def require_user
    unless current_user
      redirect_to new_user_session_path, alert: "Please sign in to continue."
    end
  end

end
