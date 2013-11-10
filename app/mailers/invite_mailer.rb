class InviteMailer < ActionMailer::Base
  default from: "no-reploy@example.com"

  def invite_email(invite)
    @invite = invite
    mail(
      to: invite.email,
      subject: "Invite to join Stevedore"
    )
  end
end
