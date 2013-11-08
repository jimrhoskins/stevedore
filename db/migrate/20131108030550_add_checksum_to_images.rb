class AddChecksumToImages < ActiveRecord::Migration
  def change
    add_column :images, :checksum, :string
  end
end
