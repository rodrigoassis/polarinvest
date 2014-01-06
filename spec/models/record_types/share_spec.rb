require 'spec_helper'

describe "Share" do
	# asset = AssetTypes::Share.find_or_create_by(
	# 	ticker: "ABC",
	# 	name: "ABC Test")

	# share = RecordTypes::Share.new(
	# 	asset_id: asset.id,
	# 	date: Time.now,
	# 	value: 22.22,
	# 	value_delta: 12.22,
	# 	percentage_delta: 1.2)

	# it "Invalid without asset_id, date, value, value_delta and percentage_delta" do
	# 	# expect(share).to be_valid
	# 	#expect(share).to be_valid
	# end

	it "Invalid without asset_id" do
		expect(RecordTypes::Share.new(asset_id: nil)).to have(1).errors_on(:asset_id)
	end

	it "Invalid without date" do
		expect(RecordTypes::Share.new(date: nil)).to have(2).errors_on(:date)
	end

	it "Invalid without value" do
		expect(RecordTypes::Share.new(value: nil)).to have(1).errors_on(:value)
	end

	it "Invalid without value_delta" do
		expect(RecordTypes::Share.new(value_delta: nil)).to have(1).errors_on(:value_delta)
	end

	it "Invalid without percentage_delta" do
		expect(RecordTypes::Share.new(percentage_delta: nil)).to have(2).errors_on(:percentage_delta)
	end
end