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

  it "is valid without total_value" do
    FactoryGirl.build(:transaction, total_value: nil).should be_valid
  end

  it "is valid without shares_quantity" do
    FactoryGirl.build(:transaction, shares_quantity: nil).should_not be_valid
  end

  it "is valid without unit_value" do
    FactoryGirl.build(:transaction, unit_value: nil).should_not be_valid
  end

  it "has total_value attributed on after commit" do
    transaction = FactoryGirl.build(:transaction, total_value: nil)
    transaction.total_value.should be_nil
    transaction.run_callbacks(:commit)
    transaction.total_value.should_not be_nil
    transaction.total_value.should eq(transaction.unit_value * transaction.shares_quantity)
  end

  it "can retrieve transaction type" do
    Transaction.all_types.should_not be_nil
    Transaction.all_types.should_not be_empty
  end

end