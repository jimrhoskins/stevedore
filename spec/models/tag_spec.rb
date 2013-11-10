require 'spec_helper'

describe Tag do
  describe :associations do
    it "belongs to a repository" do
      expect(Tag.new).to respond_to :repository
      expect(Tag.new).to respond_to :repository=
    end
  end
end
