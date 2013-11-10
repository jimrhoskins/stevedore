class RegistrationsController < Devise::RegistrationsController
  layout "sessions"
  
  before_action :require_invite, only: [:new, :create]
  after_action :commit_invite, only: [:create]

  skip_before_action :require_user


  protected

  def require_invite
    return if User.count == 0

    to = new_user_session_path

    @invite = Invite.find_by( code: params[:invite_code])
    if @invite and @invite.expired?
      redirect_to to, alert: "Invite code expired"
    elsif @invite and @invite.invitee_id
      redirect_to to, alert: "Invite code used"
    elsif @invite.nil?
      redirect_to to, alert: "Invite code not found"
    end
  end

  def commit_invite
    if @invite and @user.id
      @invite.invitee = @user
      @invite.save
    end
  end

end
