require 'spec_helper'

describe Asset do
  it "has many records" do
    FactoryGirl.create(:asset).should be_valid
  end
  it "has many investments"

end