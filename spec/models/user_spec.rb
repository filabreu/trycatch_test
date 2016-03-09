require 'rails_helper'

RSpec.describe User, type: :model do

  let!(:user) { build(:user) }
  let!(:admin) { build(:admin) }
  let!(:guest) { build(:guest) }

  context "validations" do

    it "should validate username uniqueness" do
      expect(user).to be_valid
      user.save

      new_user = build(:user)
      expect(new_user).not_to be_valid
      expect(new_user.errors).to include(:username)
    end

    it "should validate username presence" do
      expect(user).to be_valid
      user.save

      new_user = build(:user)
      expect(new_user).not_to be_valid
      expect(new_user.errors).to include(:username)
    end
  end

  context "roles" do
    it "should respond to right roles" do
      expect(admin).to be_admin
      expect(admin).not_to be_user
      expect(admin).not_to be_guest

      expect(user).not_to be_admin
      expect(user).to be_user
      expect(user).not_to be_guest

      expect(guest).not_to be_admin
      expect(guest).not_to be_user
      expect(guest).to be_guest
    end

    it "should have guest and default role" do
      new_user = User.new(username: "new_user", password: "password")

      expect(new_user).to be_guest
      expect(new_user).not_to be_user
      expect(new_user).not_to be_admin
    end
  end
end
