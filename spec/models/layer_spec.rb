require 'spec_helper'

describe Layer do
  before do
    Layer.storage_options = {
      :provider                 => 'AWS',
      :aws_access_key_id        => "key",
      :aws_secret_access_key    => "secret"
    }
    Layer.storage_bucket = "layer-storage"
    Fog.mock! 
  end


  it "puts data" do
    data = StringIO.new("the data")
    expect(Layer.put("key", data)).to be true
  end

  describe "stored data" do
    let(:data_string){"the data"}

    before do
      Layer.put("key", StringIO.new(data_string))
    end

    it "provides chunked content" do
      buffer = ""
      Layer.get("key") {|c| buffer += c}
      expect(buffer).to eq data_string
    end

    it "provides content size" do
      expect(Layer.size("key")).to eq data_string.size
    end
  end

end
