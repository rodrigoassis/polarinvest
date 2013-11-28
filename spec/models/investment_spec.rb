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

  it "can retrive subclasses" do
    InvestmentTypes::Saving.subclasses.size.should > 0
    expect(InvestmentTypes::Saving.subclasses).to eq([InvestmentTypes::Saving])
  end

end

describe InvestmentTypes::Saving do

  it "can pretend its a Investment" do
    expect(InvestmentTypes::Saving.model_name).to eq("Investment")
  end

  it "can awnser own name without modules" do
    expect(InvestmentTypes::Saving.clean_name).to eq("Saving")
  end
end