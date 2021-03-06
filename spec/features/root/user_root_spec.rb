require "rails_helper"

describe "a registered user" do
  describe "visits /" do
    it "can click on login and fill out form" do
      user_1 = User.create!(first_name: "oijasdioj", last_name: "ijd098jas", username: "ijaidjo", password: "j98jdoas", address: "1 maple st.", city: "Denver", state: "CO", zip_code: 12345)

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

    it "can click on logout" do
      user_1 = User.create!(first_name: "oijasdioj", last_name: "ijd098jas", username: "ijaidjo", password: "j98jdoas", address: "1 maple st.", city: "Denver", state: "CO", zip_code: 12345)

      visit dashboard_path

      click_on "Login"

      fill_in :username, with: user_1.username
      fill_in :password, with: user_1.password

      click_on "Log in"

      click_on "Logout"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Login")
      expect(page).to_not have_content("Logged in as")
    end

    it "can edit it's information" do
      user_1 = User.create!(first_name: "oijasdioj", last_name: "ijd098jas", username: "ijaidjo", password: "j98jdoas", address: "1 maple st.", city: "Denver", state: "CO", zip_code: 12345)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      new_first_name = "ouuuuuuuu"
      new_last_name = "uuyyyyyyyyj"

      visit dashboard_path

      expect(page).to have_content(user_1.first_name)
      expect(page).to have_content(user_1.last_name)

      click_on "Edit"

      expect(current_path).to eq(edit_user_path(user_1))

      fill_in :user_username, with: "0ijoiejoiqwje"

      click_on "Update profile"

      expect(current_path).to eq(dashboard_path)
    end

    it "will receive error if it updates information incorrectly" do
      user_1 = User.create!(first_name: "oijasdioj", last_name: "ijd098jas", username: "ijaidjo", password: "j98jdoas", address: "1 maple st.", city: "Denver", state: "CO", zip_code: 12345)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      new_first_name = ""
      new_last_name = "uuyyyyyyyyj"

      visit dashboard_path

      expect(page).to have_content(user_1.first_name)
      expect(page).to have_content(user_1.last_name)

      click_on "Edit"

      expect(current_path).to eq(edit_user_path(user_1))

      fill_in :user_username, with: new_first_name

      click_on "Update profile"

      expect(current_path).to eq(user_path(user_1))
      expect(page).to have_content("Username can't be blank")
    end

    it "can not update it's information if it is not logged in" do

      visit dashboard_path

      expect(page).to_not have_content("Edit")
    end

    it "can not update another users information" do
      user_1 = User.create!(first_name: "oijasdioj", last_name: "ijd098jas", username: "ijaidjo", password: "j98jdoas", address: "1 maple st.", city: "Denver", state: "CO", zip_code: 12345)
      user_2 = User.create!(first_name: "iiuh", last_name: "ij9898s", username: "iji897gjo", password: "j98jdoas", address: "1 maple st.", city: "Denver", state: "CO", zip_code: 12345)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit edit_user_path(user_2)

      expect(current_path).to eq(edit_user_path(user_1))
    end

    it "is taken to admin dashboard if admin edits account" do
      user_1 = User.create!(first_name: "oijasdioj", last_name: "ijd098jas", username: "ijaidjo", password: "j98jdoas", address: "1 maple st.", city: "Denver", state: "CO", zip_code: 12345, role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit edit_user_path(user_1)

      fill_in :user_username, with: "0ijoiejoiqwje"

      click_on "Update profile"

      expect(current_path).to eq(admin_dashboard_index_path)
      expect(page).to have_content("Your profile has been updated!")
    end
  end
end
