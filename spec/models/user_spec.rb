require 'spec_helper'

describe User do
  it "has valid factory" do
    FactoryGirl.create(:user).should be_valid
  end

  it "is invalid without name" do
    FactoryGirl.build(:user, name: nil).should_not be_valid
  end

  it "is invalid without email" do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end

  it "has many investments" do
    investment = FactoryGirl.create(:investment)
    expect(investment.user.investments.size).to eq 1
  end

  it "destroys related investments" do
    investment = FactoryGirl.create(:investment)
    investment.user.destroy
    expect(Investment.all.size).to eq 0
  end

end