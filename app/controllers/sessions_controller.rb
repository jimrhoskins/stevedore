class SessionsController < Devise::SessionsController
  skip_before_action :require_user, only: [:new, :create]
end
