require 'spec_helper'

describe RegistrationsController do
  render_views

  def sign_in_user provider=nil
    user = FactoryGirl.create(:user, provider: provider)
    visit "/users/sign_in"
    fill_in "Email",                 :with => user.email
    fill_in "Senha",              :with => user.password
    click_button "Entrar"
    return user
  end

  it "allows users to sign in" do
    visit "/users/sign_in"

    user = FactoryGirl.create(:user)

    sign_in user

    subject.current_user.should_not be_nil
  end

  it "doesn't allow users to sign in without password" do
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

  it "update user data with a provider" do
    user = sign_in_user :facebook

    visit "/users/edit"

    fill_in "Name",                 :with => "#{user.name} ALTERED"
    fill_in "Email",                :with => user.email

    click_button "Update"

    current_path.should == "/"
  end

  it "update user data with no provider" do
    user = sign_in_user

    visit "/users/edit"

    fill_in "Name",                 :with => "#{user.name} ALTERED"
    fill_in "Email",                :with => user.email
    fill_in "Current password",     :with => user.password

    click_button "Update"

    current_path.should == "/"
  end

  it "update user data with a invalid password" do
    user = sign_in_user

    visit "/users/edit"

    fill_in "Name",                 :with => "#{user.name} ALTERED"
    fill_in "Email",                :with => user.email
    fill_in "Current password",     :with => "wrong_password"

    click_button "Update"

    current_path.should == "/users"
  end

  it "verifies google authentication for a new user" do
    omniauth_hash = google_omniauth_hash

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

    omniauth_hash = google_omniauth_hash

    request.env["omniauth.auth"] = OmniAuth.config.add_mock(:google_oauth2, omniauth_hash)

    request.env["omniauth.auth"][:uid].should == '123545'

    user = User.find_for_google_oauth2(request.env["omniauth.auth"])

    user.should_not be_nil
    expect(user.name).to eq "John Doe"
    expect(user.email).to eq "johndoe@email.com"
  end

  it "verifies facebook authentication for a new user" do
    omniauth_hash = facebook_omniauth_hash

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

    omniauth_hash = facebook_omniauth_hash

    request.env["omniauth.auth"] = OmniAuth.config.add_mock(:facebook, omniauth_hash)

    request.env["omniauth.auth"][:uid].should == '123123123123'

    user = User.find_for_facebook_oauth(request.env["omniauth.auth"])

    user.should_not be_nil
    expect(user.name).to eq "John Doe"
    expect(user.email).to eq "johndoe@email.com"
  end

  it "verifies twitter authentication for a new user" do
    omniauth_hash = twitter_omniauth_hash

    request.env["omniauth.auth"] = OmniAuth.config.add_mock(:twitter, omniauth_hash)

    request.env["omniauth.auth"][:uid].should == '123456'

    user = User.find_for_twitter_oauth(request.env["omniauth.auth"])

    user.should_not be_nil
    user.should be_valid
    expect(user.name).to eq "John Doe"
    expect(user.email).to eq "john_doe@fake-twitter-email.com"
  end

  it "verifies twitter authentication for already registered user" do
    user = FactoryGirl.create(:user, name: "John Doe", email: "john_doe@fake_twitter_email.com", password: "password")

    omniauth_hash = twitter_omniauth_hash

    request.env["omniauth.auth"] = OmniAuth.config.add_mock(:twitter, omniauth_hash)

    request.env["omniauth.auth"][:uid].should == '123456'

    user = User.find_for_twitter_oauth(request.env["omniauth.auth"])

    user.should_not be_nil
    expect(user.name).to eq "John Doe"
    expect(user.email).to eq "john_doe@fake-twitter-email.com"
  end

end

def google_omniauth_hash
  { provider: "google_oauth2",
    uid: "123545",
    info: {name: "John Doe", email: "johndoe@email.com"},
    credentials: {token: "testtoken234tsdf"}
  }
end

def facebook_omniauth_hash
  { "provider"=>"facebook",
    "uid"=>"123123123123",
    "info"=> {
      "email"=>"johndoe@email.com", "name"=>"John Doe"
    },
    "extra"=> {
      "raw_info"=>{"name"=>"John Doe"}
    }
  }
end

def twitter_omniauth_hash
  {
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
end