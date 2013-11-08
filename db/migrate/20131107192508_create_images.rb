class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :repository_id
      t.string :uid
      t.string :tag
      t.integer :order
      t.text :json

      t.timestamps
    end
  end
end
