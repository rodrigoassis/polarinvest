require 'spec_helper'

describe SessionsController do
  render_views

  def sign_in_user provider=nil
    user = FactoryGirl.create(:user, provider: provider)
    visit "/users/sign_in"
    fill_in "Email", with: user.email
    fill_in "Senha", with: user.password
    click_button "Entrar"
    return user
  end

  it "validates email presence" do
    visit "/users/sign_in"

    click_button "Entrar"

    page.should have_content("Email ou senha inválidos.")
  end

  it "has logout button" do
    sign_in_user

    visit root_path

    page.should_not have_content("Login")
    page.should     have_content("Logout")

    first('.heronav.right').click_link("Logout")

    page.should have_content("Login")
  end

end
