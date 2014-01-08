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
end