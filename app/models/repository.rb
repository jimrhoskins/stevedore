class Repository < ActiveRecord::Base
  has_many :repository_images, -> { order "idx" }
  has_many :images, through: :repository_images
  has_many :tokens
  has_many :tags

  def to_param
    name
  end

  def self.put(name, images_json)
    repo = find_or_create_by(name: name)

    if images_json
      repo.repository_images.destroy_all

      images_json.each_with_index do |img, index|
        repo.repository_images.create(
          image: Image.find_or_create_by(uid: img["id"]),
          tag: img["Tag"],
          idx: index
        )
      end
    end

    repo
  end


  def json
    repository_images.map do |ri|
      {
        "id" => ri.image.uid,
        "Tag" => ri.tag
      }
    end
  end

end
