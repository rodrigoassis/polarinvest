require 'spec_helper'

describe "Assets" do

  describe "GET /assets" do
    it "doesn't work as not loged in" do
      get dashboard_assets_path
      expect(response.status).to eq(302)
    end

    it "works as user loged in" do
      sign_in_as_a_valid_user
      get dashboard_assets_path
      expect(response.status).to eq(200)
    end
  end

end
