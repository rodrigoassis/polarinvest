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

  it "verifies google authentication for a new user" do
    omniauth_hash = { provider: "google_oauth2",
                      uid: "123545",
                      info: {name: "John Doe", email: "johndoe@email.com"},
                      credentials: {token: "testtoken234tsdf"}
                    }

    request.env["omniauth.auth"] = OmniAuth.config.add_mock(:google_oauth2, omniauth_hash)

    request.env["omniauth.auth"][:uid].should == '123545'

    user = User.find_for_google_oauth2(request.env["omniauth.auth"])

    user.should_not be_nil
    user.should be_valid
    expect(user.name).to eq "John Doe"
    expect(user.email).to eq "johndoe@email.com"
  end

  it "verifies google authentication for already registered user" do
    user = FactoryGirl.create(:user, name: "John Doe", email: "johndoe@email.com", password: "password")

    omniauth_hash = { provider: "google_oauth2",
                      uid: "123545",
                      info: {name: "John Doe", email: "johndoe@email.com"},
                      credentials: {token: "testtoken234tsdf"}
                    }

    request.env["omniauth.auth"] = OmniAuth.config.add_mock(:google_oauth2, omniauth_hash)

    request.env["omniauth.auth"][:uid].should == '123545'

    user = User.find_for_google_oauth2(request.env["omniauth.auth"])

    user.should_not be_nil
    expect(user.name).to eq "John Doe"
    expect(user.email).to eq "johndoe@email.com"
  end

  it "verifies facebook authentication for a new user" do
    omniauth_hash = { "provider"=>"facebook",
                      "uid"=>"123123123123",
                      "info"=> {
                        "email"=>"johndoe@email.com", "name"=>"John Doe"
                      },
                      "extra"=> {
                        "raw_info"=>{"name"=>"John Doe"}
                      }
                    }

    
    request.env["omniauth.auth"] = OmniAuth.config.add_mock(:facebook, omniauth_hash)

    request.env["omniauth.auth"][:uid].should == '123123123123'

    user = User.find_for_facebook_oauth(request.env["omniauth.auth"])

    user.should_not be_nil
    user.should be_valid
    expect(user.name).to eq "John Doe"
    expect(user.email).to eq "johndoe@email.com"
  end

  it "verifies facebook authentication for already registered user" do
    user = FactoryGirl.create(:user, name: "John Doe", email: "johndoe@email.com", password: "password")

    omniauth_hash = { "provider"=>"facebook",
                      "uid"=>"123123123123",
                      "info"=> {
                        "email"=>"johndoe@email.com", "name"=>"John Doe"
                      },
                      "extra"=> {
                        "raw_info"=>{"name"=>"John Doe"}
                      }
                    }

    request.env["omniauth.auth"] = OmniAuth.config.add_mock(:facebook, omniauth_hash)

    request.env["omniauth.auth"][:uid].should == '123123123123'

    user = User.find_for_facebook_oauth(request.env["omniauth.auth"])

    user.should_not be_nil
    expect(user.name).to eq "John Doe"
    expect(user.email).to eq "johndoe@email.com"
  end

  it "verifies twitter authentication for a new user" do
    omniauth_hash = {
                      :provider => "twitter",
                      :uid => "123456",
                      :info => {
                        :nickname => "john_doe",
                        :name => "John Doe",
                        :description => "a very normal guy.",
                        :urls => {
                          :Website => nil,
                          :Twitter => "https://twitter.com/john_doe"
                        }
                      },
                       :extra => {
                        :access_token => "", # An OAuth::AccessToken object
                        :raw_info => {
                          :name => "John Q Public",
                          :listed_count => 0,
                          :profile_sidebar_border_color => "181A1E",
                          :url => nil,
                          :lang => "en",
                          :statuses_count => 129,
                          :profile_image_url => "http://si0.twimg.com/sticky/default_profile_images/default_profile_2_normal.png",
                          :profile_background_image_url_https => "https://twimg0-a.akamaihd.net/profile_background_images/229171796/pattern_036.gif",
                          :location => "Anytown, USA",
                          :time_zone => "Chicago",
                          :follow_request_sent => false,
                          :id => 123456,
                          :profile_background_tile => true,
                          :profile_sidebar_fill_color => "666666",
                          :followers_count => 1,
                          :default_profile_image => false,
                          :screen_name => "",
                          :following => false,
                          :utc_offset => -3600,
                          :verified => false,
                          :favourites_count => 0,
                          :profile_background_color => "1A1B1F",
                          :is_translator => false,
                          :friends_count => 1,
                          :notifications => false,
                          :geo_enabled => true,
                          :profile_background_image_url => "http://twimg0-a.akamaihd.net/profile_background_images/229171796/pattern_036.gif",
                          :protected => false,
                          :description => "a very normal guy.",
                          :profile_link_color => "2FC2EF",
                          :created_at => "Thu Jul 4 00:00:00 +0000 2013",
                          :id_str => "123456",
                          :profile_image_url_https => "https://si0.twimg.com/sticky/default_profile_images/default_profile_2_normal.png",
                          :default_profile => false,
                          :profile_use_background_image => false,
                          :entities => {
                            :description => {
                              :urls => []
                            }
                          },
                          :profile_text_color => "666666",
                          :contributors_enabled => false
                        }
                      }
                    }


    request.env["omniauth.auth"] = OmniAuth.config.add_mock(:twitter, omniauth_hash)

    request.env["omniauth.auth"][:uid].should == '123456'

    user = User.find_for_twitter_oauth(request.env["omniauth.auth"])

    user.should_not be_nil
    user.should be_valid
    expect(user.name).to eq "John Doe"
    expect(user.email).to eq "john_doe@fake_twitter_email.com"
  end

  it "verifies twitter authentication for already registered user" do
    user = FactoryGirl.create(:user, name: "John Doe", email: "john_doe@fake_twitter_email.com", password: "password")

    omniauth_hash = {
                      :provider => "twitter",
                      :uid => "123456",
                      :info => {
                        :nickname => "john_doe",
                        :name => "John Doe",
                        :description => "a very normal guy.",
                        :urls => {
                          :Website => nil,
                          :Twitter => "https://twitter.com/john_doe"
                        }
                      },
                       :extra => {
                        :access_token => "", # An OAuth::AccessToken object
                        :raw_info => {
                          :name => "John Q Public",
                          :listed_count => 0,
                          :profile_sidebar_border_color => "181A1E",
                          :url => nil,
                          :lang => "en",
                          :statuses_count => 129,
                          :profile_image_url => "http://si0.twimg.com/sticky/default_profile_images/default_profile_2_normal.png",
                          :profile_background_image_url_https => "https://twimg0-a.akamaihd.net/profile_background_images/229171796/pattern_036.gif",
                          :location => "Anytown, USA",
                          :time_zone => "Chicago",
                          :follow_request_sent => false,
                          :id => 123456,
                          :profile_background_tile => true,
                          :profile_sidebar_fill_color => "666666",
                          :followers_count => 1,
                          :default_profile_image => false,
                          :screen_name => "",
                          :following => false,
                          :utc_offset => -3600,
                          :verified => false,
                          :favourites_count => 0,
                          :profile_background_color => "1A1B1F",
                          :is_translator => false,
                          :friends_count => 1,
                          :notifications => false,
                          :geo_enabled => true,
                          :profile_background_image_url => "http://twimg0-a.akamaihd.net/profile_background_images/229171796/pattern_036.gif",
                          :protected => false,
                          :description => "a very normal guy.",
                          :profile_link_color => "2FC2EF",
                          :created_at => "Thu Jul 4 00:00:00 +0000 2013",
                          :id_str => "123456",
                          :profile_image_url_https => "https://si0.twimg.com/sticky/default_profile_images/default_profile_2_normal.png",
                          :default_profile => false,
                          :profile_use_background_image => false,
                          :entities => {
                            :description => {
                              :urls => []
                            }
                          },
                          :profile_text_color => "666666",
                          :contributors_enabled => false
                        }
                      }
                    }


    request.env["omniauth.auth"] = OmniAuth.config.add_mock(:twitter, omniauth_hash)

    request.env["omniauth.auth"][:uid].should == '123456'

    user = User.find_for_twitter_oauth(request.env["omniauth.auth"])

    user.should_not be_nil
    expect(user.name).to eq "John Doe"
    expect(user.email).to eq "john_doe@fake_twitter_email.com"
  end

end
