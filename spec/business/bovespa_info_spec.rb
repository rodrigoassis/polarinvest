require 'spec_helper'

describe "BovespaInfo" do
	# Class method self.extract_codes
	it "returns an array of codes" do
		expect(BovespaInfo.extract_codes).to_not eq nil
	end

	# Class method self.extract_codes
	it "returns an array of codes" do
		expect(BovespaInfo.extract_codes).to_not eq ""
	end

  it "returns an array of market situation" do
    expect(BovespaInfo.fetch_codes).to_not eq ""
  end

  it "returns an array of market situation" do
    expect(BovespaInfo.fetch_codes).to_not eq nil
  end

  it "find a ticker" do
    AssetTypes::Share.create(ticker: "PETR4", name: "Petrobras")

    expect(BovespaInfo.find_share("PETR4", "")).to be_true
  end

  it "create a ticker" do
    expect(BovespaInfo.find_share("PETR4", "")).to be_true
  end

  it "create a historical value" do
    AssetTypes::Share.create(ticker: "PETR4", name: "Petrobras")
    asset = Asset.all.first
    line = "012012010202ABCB4       010ABC BRASIL  PN  EJ  N2   R$  000000000122100000000012440000000001175000000000119400000000011850000000001185000000000119300465000000000000131800000000000157420100000000000000009999123100000010000000000000BRABCBACNPR4117"

    expect(BovespaInfo.save_history_values(line, asset)).to be_true
  end
end
