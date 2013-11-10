class V1::UsersController < V1::IndexController
  skip_before_action :require_user

  def create
    user = User.find_by username: params[:username]
    if user and user.valid_password? params[:password]
      render status: 201, text: "OK"
    else
      render status: 401, text: "Unauthorized"
    end
  end
end
