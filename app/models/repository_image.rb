class RepositoryImage < ActiveRecord::Base
  belongs_to :repository
  belongs_to :image
end
