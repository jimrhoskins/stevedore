class Invite < ActiveRecord::Base
  belongs_to :inviter, class_name: "User"
  belongs_to :invitee, class_name: "User"

  validates :inviter_id, presence: true

  before_validation on: :create do
    self.code = SecureRandom.hex
    self.expires_at = 5.days.from_now
  end

  def expired?
    expires_at < Time.now
  end
end
