class Image < ActiveRecord::Base
  belongs_to :parent, class_name: "Image"

  def set_json(json)
    parent_id = json["parent"]

    if parent_id
      parent = Image.find_by uid: parent_id
      self.parent = parent
    end

    self.json = json.to_json

    save
  end
end
