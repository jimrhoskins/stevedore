require 'spec_helper'

describe "signing up" do
  context "fresh install" do
    before { User.destroy_all }

    it "allows you to sign up" do
      visit new_user_registration_path

      fill_in "Username", with: "johndoe"
      fill_in "Email", with: "joehndoe@example.com"
      fill_in "user_password", with: "hunter2!"
      fill_in "user_password_confirmation", with: "hunter2!"
      
      click_on "Sign up"

      expect(page.current_url).to eq root_url
    end
  end

  context "with users created" do
    let(:inviter){ FactoryGirl.create(:user) }

    before do
      FactoryGirl.create(:user)
    end

    context "with valid invite" do
      let(:invite){ inviter.invites.create(email: "joe@example.com")}

      it "allows you to sign up" do
        visit new_user_registration_path(invite_code: invite.code)

        fill_in "Username", with: "johndoe"
        fill_in "Email", with: "joehndoe@example.com"
        fill_in "user_password", with: "hunter2!"
        fill_in "user_password_confirmation", with: "hunter2!"
        
        click_on "Sign up"

        expect(page.current_url).to eq root_url
      end
    end

    context "with invalid invite" do
      it "will not allow the registration" do
        visit new_user_registration_path(invite_code: "bad-code")
        expect(page.current_url).to eq new_user_session_url
      end
    end

    context "with no invite" do
      it "will not allow the registration" do
        visit new_user_registration_path
        expect(page.current_url).to eq new_user_session_url
      end
    end

    context "with expired invite" do
      it "will not allow the registration" do
        invite = inviter.invites.create(email: "joe@example.com")
        invite.expires_at = 1.minute.ago
        invite.save

        visit new_user_registration_path(invite_code: invite.code)
        expect(page.current_url).to eq new_user_session_url
      end
    end
  end
end
