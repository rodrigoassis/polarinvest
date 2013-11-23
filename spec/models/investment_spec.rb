require 'spec_helper'

describe Investment do

  it "has valid factory" do
    FactoryGirl.create(:investment).should be_valid
  end

  it "is invalid without asset" do
    FactoryGirl.build(:investment, asset: nil).should_not be_valid
  end

  it "is invalid without user" do
    FactoryGirl.build(:investment, user: nil).should_not be_valid
  end

end