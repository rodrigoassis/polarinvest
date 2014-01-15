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

  it "destroys related records" do
    record = FactoryGirl.create(:record)
    record.asset.destroy
    expect(Record.all.size).to eq 0
  end

  it "has many investments" do
    investment = FactoryGirl.create(:investment)
    expect(investment.asset.investments.size).to eq 1
  end

  it "destroys related investments" do
    investment = FactoryGirl.create(:investment)
    investment.asset.destroy
    expect(Investment.all.size).to eq 0
  end

  it "can retrive subclasses" do
    AssetTypes::Saving.subclasses.size.should > 0
    expect(AssetTypes::Saving.subclasses).to eq([AssetTypes::Saving, AssetTypes::Stock])
  end

  it "can get records values from a start date" do
    asset = FactoryGirl.create(:asset)
    record = FactoryGirl.create(:record, asset_id: asset.id)

    # Default factory it's Time.now - 7.days
    expect(asset.values_from(Time.now - 1.day)).to eq([]) # too short time range
    asset.values_from(Time.now - 14.day).should_not be([]) # long, valid range
  end

end

describe AssetTypes::Saving do
  it "can pretend its a Asset" do
    expect(AssetTypes::Saving.model_name).to eq("Asset")
  end

  it "can awnser own name without modules" do
    expect(AssetTypes::Saving.clean_name).to eq("Saving")
  end
end

describe AssetTypes::Stock do
  it "can pretend its a Asset" do
    expect(AssetTypes::Stock.model_name).to eq("Asset")
  end

  it "can awnser own name without modules" do
    expect(AssetTypes::Stock.clean_name).to eq("Stock")
  end
end