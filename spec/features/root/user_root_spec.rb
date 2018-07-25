require "rails_helper"

describe "a registered user" do
  describe "visits /" do
    it "can click on login and fill out form" do
      user_1 = User.create!(first_name: "oijasdioj", last_name: "ijd098jas", username: "ijaidjo", password: "j98jdoas")

      visit root_path

      click_on "Login"

      expect(current_path).to eq(login_path)

      fill_in :username, with: user_1.username
      fill_in :password, with: user_1.password

      click_on "Log in"

      expect(current_path).to eq("/dashboard")
      expect(page).to have_content("Logged in as #{user_1.first_name}")
      expect(page).to have_content(user_1.first_name)
      expect(page).to have_content(user_1.last_name)

      expect(page).to have_content("Logout")
      expect(page).to_not have_content("Login")
    end

    it "can edit it's information" do
      user_1 = User.create!(first_name: "oijasdioj", last_name: "ijd098jas", username: "ijaidjo", password: "j98jdoas")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      new_first_name = "oi90js"
      new_last_name = "o12e890dasj"

      visit dashboard_path

      expect(page).to have_content(user_1.first_name)
      expect(page).to have_content(user_1.last_name)

      click_on "Edit"

      expect(current_path).to eq(edit_user_path(user_1))

      fill_in :user_first_name, with: new_first_name
      fill_in :user_first_name, with: new_last_name

      click_on "Update"

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content(new_first_name)
      expect(page).to have_content(new_last_name)
    end

    xit "can not update it's information if it is not logged in" do

      visit dashboard_path

      expect(page).to_not have_content("Edit")
    end
  end
end
