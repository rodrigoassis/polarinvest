require 'spec_helper'

describe "Bovespa" do
	# Class method self.extract_codes
	it "returns an array of codes" do
		expect(Business::Bovespa.extract_codes).to_not eq nil
	end

	# Class method self.extract_codes
	it "returns an array of codes" do
		expect(Business::Bovespa.extract_codes).to_not eq ""
	end

  it "returns an array of market situation" do
    expect(Business::Bovespa.fetch_codes).to_not eq ""
  end

  it "returns an array of market situation" do
    expect(Business::Bovespa.fetch_codes).to_not eq nil
  end

  it "find a ticker" do
    AssetTypes::Share.create(ticker: "PETR4", name: "Petrobras")

    expect(Business::Bovespa.find_share("PETR4", "")).to be_true
  end

  it "create a ticker" do
    expect(Business::Bovespa.find_share("PETR4", "")).to be_true
  end

  it "create a historical value" do
    AssetTypes::Share.create(ticker: "PETR4", name: "Petrobras")
    asset = Asset.all.first
    line = "00COTAHIST.2012BOVESPA 20121228                                                                                                                                                                                                                      \r\n"

    expect(Business::Bovespa.save_history_values(line, asset)).to be_true
  end
end
