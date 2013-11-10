class UpdateToken < ActiveRecord::Migration
  def change
    remove_column :tokens, :repository_id
    add_column :tokens, :user_id, :integer
  end
end
