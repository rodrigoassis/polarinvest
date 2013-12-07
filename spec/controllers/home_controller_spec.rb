require 'spec_helper'

describe HomeController do
  render_views

  def sign_in_user provider=nil
    user = FactoryGirl.create(:user, provider: provider)
    visit "/users/sign_in"
    fill_in "Email",                 :with => user.email
    fill_in "Senha",              :with => user.password
    click_button "Entrar"
    return user
  end

  it "don't allows users to sign an account with any form data" do
    visit "/users/sign_up"

    click_button "Cadastrar"

    page.should have_content("Email não pode ficar em branco")
    page.should have_content("Senha não pode ficar em branco")
    page.should have_content("Nome não pode ficar em branco")
  end

  it "don't allows users to sign with password different" do
    visit "/users/sign_up"

    fill_in "Nome",   with: "Commom User"
    fill_in "Email",  with: "user@example.com"
    fill_in "Senha",  with: "password"
    fill_in "Confirmação da senha", with: "very_different_password"

    click_button "Cadastrar"

    page.should have_content("não está de acordo com a confirmação")
  end

  it "allows users to sign an account with a name" do
    visit "/users/sign_up"

    fill_in "Nome",  with: "Regular User"
    fill_in "Email", with: "user@example.com"
    fill_in "Senha", with: "password"
    fill_in "Confirmação da senha", with: "password"

    click_button "Cadastrar"

    current_path.should == "/dashboard"
  end

  it "allows signed user to access dashboard" do
    user = sign_in_user
    visit "/dashboard"

    current_path.should == "/dashboard"
  end

  it "don't allows visitant to access dashboard without sign_in" do
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
