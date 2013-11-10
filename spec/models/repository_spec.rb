require 'spec_helper'

describe Repository do

  let(:images) do
    [
      {"id" => "abcdef", "Tag" => "latest"},
      {"id" => "123456", "Tag" => "latest"},
      {"id" => "7890ab", "Tag" => "latest"}
    ]
  end

  describe :associations do


    let(:repo){Repository.new}

    it "has many repository_images" do
      expect(repo).to respond_to :repository_images
      expect(repo).to respond_to :repository_images=
    end

    it "has many images" do
      expect(repo).to respond_to :images
      expect(repo).to respond_to :images=
    end

    it "has many tokens" do
      expect(repo).to respond_to :tokens
      expect(repo).to respond_to :tokens=
    end

    it "has many tags" do
      expect(repo).to respond_to :tags
      expect(repo).to respond_to :tags=
    end

  end

  it "uses the name as the param" do
    repo = Repository.new(name: "foo/bar")
    expect(repo.to_param).to eq "foo/bar"
  end

  describe :put do

    before { Repository.put("foo/bar", images) }

    it "creates a repo" do
      expect(Repository.find_by name: "foo/bar").to_not be_nil
    end

    it "sets the images for the repo" do
      repo = Repository.find_by name: "foo/bar"
      expect(repo.images.size).to be 3
    end

  end

  describe :json do
    let(:repo){ Repository.put("foo/bar", images)}

    it "provides the id and tag" do
      json = repo.json
      expect(json.size).to be 3
      expect(json[0]["id"]).to eq images[0]["id"]
    end
  end

end


