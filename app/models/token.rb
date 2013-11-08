class Token < ActiveRecord::Base
  belongs_to :repository

  validates_presence_of :repository_id, :signature
  validates_inclusion_of :access, in: %w(read write delete)

  before_validation on: :create do
    self.signature = SecureRandom.hex
  end

  def to_s
    "signature=#{signature},repository\"#{repository.name}\",access=#{access}"
  end
end
