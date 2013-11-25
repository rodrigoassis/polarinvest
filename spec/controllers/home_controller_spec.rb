require 'spec_helper'

describe HomeController do
  it "don't allows users to register an account with any form data" do
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

  it "don't allows users to register with password different" do
    visit "/users/sign_up"

    fill_in "Name",    :with => "Commom User"
    fill_in "Email",    :with => "user@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "vry_different_password"

    click_button "Sign up"

    page.should have_content("Password confirmation doesn't match Password")
  end

  it "allows users to register an account with a name" do
    visit "/users/sign_up"

    fill_in "Name",    :with => "Regular User"
    fill_in "Email",    :with => "user@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"

    click_button "Sign up"

    current_path.should == "/"
  end

  it "allows users to sign in" do
    visit "/users/sign_in"

    user = FactoryGirl.create(:user)

    sign_in user

    subject.current_user.should_not be_nil
  end

  it "don't allows users to sign in with no password" do
    visit "/users/sign_in"

    user = FactoryGirl.build(:user, password: "")

    sign_in user

    subject.current_user.should be_nil
    current_path.should == "/users/sign_in"
  end

  it "allows users to sign out" do
    visit "/users/sign_in"

    user = FactoryGirl.create(:user)

    sign_in user

    sign_out :user
    
    subject.current_user.should be_nil
  end
end
