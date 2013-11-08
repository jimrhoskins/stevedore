class CreateRepositoryImages < ActiveRecord::Migration
  def change
    create_table :repository_images do |t|
      t.integer :repository_id
      t.integer :image_id
      t.integer :idx
      t.string :tag

      t.timestamps
    end

    remove_column :images, :repository_id
    remove_column :images, :order
    remove_column :images, :tag

  end
end
