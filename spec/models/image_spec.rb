require 'spec_helper'

describe Image do
  describe :associations do
    it 'has a parent' do
      expect(Image.new).to respond_to :parent
      expect(Image.new).to respond_to :parent=
    end
  end

  describe :set_json do
    let(:parent){ Image.create(uid: "abcdefabcdef")}
    let(:image){ Image.new(uid: "0123456789abcdef")}
    let(:built_at){ 1.day.ago }
    
    before do
      image.set_json({
        "parent" => parent.uid,
        "created" => built_at.iso8601
      })
    end

    it 'sets the parent' do
      expect(image.parent).to eq parent
    end

    it 'saves json data' do
      expect(image.json).to_not be_empty
      expect(image.parsed_json['parent']).to eq parent.uid
    end

    it 'provides the built_at time' do
      expect(image.built_at.to_i).to eq built_at.to_i
    end
  end

  describe :size do
    let(:image){ Image.new(uid: "abc" )}
    before do
      Layer.stub(:size).with(image.uid){ 123 }
    end

    it 'returns the correct size' do
      expect(image.size).to eq 123
    end
  end

  it "useses the uid as param" do
    expect(Image.new(uid: "123").to_param).to eq "123"
  end

end
