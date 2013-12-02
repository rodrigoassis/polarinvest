require 'spec_helper'

describe "Transactions" do

  describe "GET /transactions" do
    it "doesn't work as not loged in" do
      get transactions_path
      expect(response.status).to eq(302)
    end

    it "works as user loged in" do
      sign_in_as_a_valid_user
      get transactions_path
      expect(response.status).to eq(200)
    end
  end

end
