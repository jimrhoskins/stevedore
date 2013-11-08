class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :repository_id
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
