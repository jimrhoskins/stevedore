class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :code
      t.string :email
      t.integer :inviter_id
      t.integer :invitee_id
      t.datetime :expires_at

      t.timestamps
    end
  end
end
