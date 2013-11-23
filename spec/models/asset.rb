require 'spec_helper'

describe Asset do

  it "has valid factory" do
    FactoryGirl.create(:asset).should be_valid
  end

  it "is invalid without name" do
    FactoryGirl.build(:asset, name: nil).should_not be_valid
  end

  it "is invalid without type" do
    FactoryGirl.build(:asset, type: nil).should_not be_valid
  end

  it "has many records" do
    record = FactoryGirl.create(:record)
    expect(record.asset.records.size).to eq 1
  end

  it "has many investments" do
    record = FactoryGirl.create(:investment)
    expect(record.asset.investments.size).to eq 1
  end

end