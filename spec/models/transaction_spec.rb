require 'spec_helper'

describe Transaction do

  it "has valid factory" do
    FactoryGirl.create(:transaction).should be_valid
  end

  it "is invalid without investment" do
    FactoryGirl.build(:transaction, investment: nil).should_not be_valid
  end

  it "is invalid without date" do
    FactoryGirl.build(:transaction, date: nil).should_not be_valid
  end

  it "is invalid without transaction_type" do
    FactoryGirl.build(:transaction, transaction_type: nil).should_not be_valid
  end

  it "is invalid without total_value" do
    FactoryGirl.build(:transaction, total_value: nil).should_not be_valid
  end

  it "is valid without shares_quantity" do
    FactoryGirl.build(:transaction, shares_quantity: nil).should be_valid
  end

  it "is valid without unit_value" do
    FactoryGirl.build(:transaction, unit_value: nil).should be_valid
  end

end