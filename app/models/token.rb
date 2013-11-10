class Token < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id, :signature

  before_validation on: :create do
    self.signature = SecureRandom.hex
  end

  def to_s
    "signature=#{signature}"
  end
end
