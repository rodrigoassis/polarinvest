require 'spec_helper'

describe Transaction do

  it "has valid factory" do
    FactoryGirl.create(:investment).should be_valid
  end

end