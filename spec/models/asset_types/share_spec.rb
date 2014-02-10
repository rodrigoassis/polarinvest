require 'spec_helper'

describe "Share" do
	# share = AssetTypes::Share.new(
	# 	ticker: "CDE",
	# 	name: "CDE Test")

	it "Invalid without ticker" do
		expect(AssetTypes::Share.new(ticker: nil)).to have(1).errors_on(:ticker)
	end

	it "Have display name" do
		share = AssetTypes::Share.create(ticker: "TEST",name: "Test")

		expect(share.display_name).to eq("Test - TEST")
	end

	it "Ticker must be unique" do
		AssetTypes::Share.create(
			ticker: "TEST",
			name: "Test")

		share = AssetTypes::Share.new(
			ticker: "TEST",
			name: "Anything")

		expect(share).to have(1).errors_on(:ticker)
	end

	it "Invalid without name" do
		expect(AssetTypes::Share.new(name: nil)).to have(2).errors_on(:name)
	end
end