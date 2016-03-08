require 'rails_helper'

RSpec.describe User, type: :model do

  let!(:user) { build(:user) }

  it "should validate username uniqueness" do
    expect(user).to be_valid
    user.save
    new_user = build(:user)
    expect(new_user).not_to be_valid
    expect(new_user.errors).to include(:username)
  end
end
