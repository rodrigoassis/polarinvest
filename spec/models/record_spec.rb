require 'spec_helper'

describe Record do
  it "has valid factory" do
    FactoryGirl.create(:record).should be_valid
  end

  it "is invalid without date" do
    FactoryGirl.build(:record, date: nil).should_not be_valid
  end

  it "is invalid without type" do
    FactoryGirl.build(:record, type: nil).should_not be_valid
  end

  it "is invalid without asset" do
    FactoryGirl.build(:record, asset: nil).should_not be_valid
  end

  it "is invalid without percentage_delta" do
    FactoryGirl.build(:record, percentage_delta: nil).should_not be_valid
  end

  it "is valid without value_delta" do
    FactoryGirl.build(:record, value_delta: nil).should be_valid
  end

  it "is valid without value" do
    FactoryGirl.build(:record, value_delta: nil).should be_valid
  end
end