require 'spec_helper'

describe SessionsController do
  render_views

  it "validates email presence" do
    visit "/users/sign_in"

    click_button "Entrar"

    page.should have_content("Email ou senha inválidos.")
  end

end
