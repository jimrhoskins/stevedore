class Image < ActiveRecord::Base
  belongs_to :parent, class_name: "Image"
  has_many :repository_images
  has_many :repositories, through: :repository_images

  def set_json(json)
    parent_id = json["parent"]

    if parent_id
      parent = Image.find_by uid: parent_id
      self.parent = parent
    end

    self.json = json.to_json

    save
  end


  def parsed_json
    @parsed_json ||= JSON.parse(json)
  rescue
    {}
  end

  def built_at
    DateTime.parse parsed_json["created"]
  end

  def to_param
    uid
  end


  def size
    Layer.size(uid)
  end
end
