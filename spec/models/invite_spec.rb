require 'spec_helper'

describe Invite do
  let(:invite){Invite.new}

  context :associations do
    it 'has an inviter' do
      expect(invite).to respond_to :inviter
      expect(invite).to respond_to :inviter=
    end

    it 'has an invitee' do
      expect(invite).to respond_to :invitee
      expect(invite).to respond_to :invitee=
    end
  end

  context "newly saved invite" do
    before do
      invite.save
    end

    it "sets the code" do
      expect(invite.code).to match /[a-z0-9]+/
    end

    it "sets expires at" do
      expect(invite.expires_at.to_i).to be >  Time.now.to_i
    end
  end

  describe :expired? do
    it "is expired if expired_at is in the past" do
      invite.expires_at = 1.minute.ago
      expect(invite.expired?).to be true
    end

    it "is not expired if expired_at is in the future" do
      invite.expires_at = 1.minute.from_now
      expect(invite.expired?).to be false
    end
  end

  it "requires inviter" do
    expect(invite.save).to be false
    expect(invite.errors[:inviter_id]).to_not be_empty
  end
end
