require 'rails_helper'

describe User, type: :model do
  describe 'Validatons' do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
    it {should validate_presence_of(:username)}
    it {should validate_uniqueness_of(:username)}
    it {should validate_presence_of(:password)}
    it {should validate_presence_of(:role)}
    it {should validate_presence_of(:address)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
    it {should validate_presence_of(:zip_code)}
  end
  describe 'Relationships' do
    it {should have_many(:orders)}
  end
  describe 'roles' do
    it 'can be created as an admin' do
      user = User.create(username: 'Seth', password: 'password', role: 1)

      expect(user.role).to eq("admin")
      expect(user.admin?).to be_truthy
    end
    it 'can be created as a default user' do
      user = User.create(username: 'Keegan', password: 'test123', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end
  end
  describe 'instance methods' do
    it "#full_name" do
      user = User.create(first_name: "best", last_name: "ever", username: 'Keegan', password: 'test123', role: 0)

      expect(user.full_name).to eq("best ever")
    end
  end

end
