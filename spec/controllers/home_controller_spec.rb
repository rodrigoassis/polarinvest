require 'spec_helper'

describe HomeController do
  render_views

  def sign_in_user provider=nil
    user = FactoryGirl.create(:user, provider: provider)
    visit "/users/sign_in"
    fill_in "Email",                 :with => user.email
    fill_in "Password",              :with => user.password
    click_button "Sign in"
    return user
  end

  it "don't allows users to sign an account with any form data" do
    visit "/users/sign_up"

    # fill_in "Name",    :with => "Commom User"
    # fill_in "Email",    :with => "user@example.com"
    # fill_in "Password", :with => "password"
    # fill_in "Password confirmation", :with => "password"

    click_button "Sign up"

    page.should have_content("Email can't be blank")
    page.should have_content("Password can't be blank")
    page.should have_content("Name can't be blank")
  end

  it "don't allows users to sign with password different" do
    visit "/users/sign_up"

    fill_in "Name",    :with => "Commom User"
    fill_in "Email",    :with => "user@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "very_different_password"

    click_button "Sign up"

    page.should have_content("Password confirmation doesn't match Password")
  end

  it "allows users to sign an account with a name" do
    visit "/users/sign_up"

    fill_in "Name",    :with => "Regular User"
    fill_in "Email",    :with => "user@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"

    click_button "Sign up"

    current_path.should == "/"
  end

  it "allows user to access dashboard" do
    user = sign_in_user
    visit "/dashboard"

    current_path.should == "/dashboard"
  end

  it "allows signed user to access dashboard" do
    user = sign_in_user
    visit "/dashboard"

    current_path.should == "/dashboard"
  end

  it "don't allows user to access dashboard without sign_in" do
    visit "/dashboard"

    current_path.should == "/users/sign_in"
  end

  it "can retrieve asset from search" do
    asset = FactoryGirl.create(:asset)
    visit "/"

    fill_in "Asset", with: "Poupança"
    click_button "Search"
    
    current_path.should == "/"
  end

end
