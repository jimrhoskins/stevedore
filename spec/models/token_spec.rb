require 'spec_helper'

describe Token do
  describe :associations do
    it "belongs to a user" do
      expect(Token.new).to respond_to :user=
      expect(Token.new).to respond_to :user
    end
  end

  describe :validations do
    let(:token){Token.new}
    it "requires user_id" do
      expect(token.save).to be false
      expect(token.errors[:user_id]).to_not be_nil
    end

    it "sets signature" do
      token.save
      expect(token.signature).to match /[a-z0-9]+/
    end
  end
end
