class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tokens
  has_many :invites, foreign_key: :inviter_id
  has_one :invite, foreign_key: :invitee_id
end
