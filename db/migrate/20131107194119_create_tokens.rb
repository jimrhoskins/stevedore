class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :signature
      t.integer :repository_id
      t.string :access

      t.timestamps
    end
  end
end
