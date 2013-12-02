require 'spec_helper'

describe TransactionsHelper do
  it "can translate dates" do
    time = Time.new(2013, 8, 21)
    helper.format_date(time).should eq("Aug, 21 2013")
  end
end