require 'spec_helper'

describe ErrorsController do
  render_views

  it 'invalid path should respond with 404 page' do
    visit '/invalid_path'

    response.code.should eq("200")
    response.should render_template("errors/404")
    page.should have_content("Oops! Desculpe mas não conseguimos encontrar essa página...")
    page.should have_content("Acesse outros links ou se o erro persistir entre em contato conosco.")
  end

  it '/404 should respond with 404 page' do
    visit '/404'

    response.code.should eq("200")
    response.should render_template("errors/404")
    page.should have_content("Oops! Desculpe mas não conseguimos encontrar essa página...")
    page.should have_content("Acesse outros links ou se o erro persistir entre em contato conosco.")
  end

  it '/500 should respond with 500 page' do
    visit '/500'

    response.code.should eq("200")
    response.should render_template("errors/500")
    page.should have_content("Oops! Desculpe mas houve um problema nos servidores...")
    page.should have_content("Acesse outros links ou se o erro persistir entre em contato conosco.")
  end

end
