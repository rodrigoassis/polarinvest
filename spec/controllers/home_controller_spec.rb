require 'spec_helper'

describe HomeController do
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

end
