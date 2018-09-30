require 'rails_helper'

include Helpers

describe "Beer" do
  before :each do
    FactoryBot.create :user
    sign_in(username:"Pekka", password:"Foobar1")
  end

  let!(:brewery) { FactoryBot.create :brewery, name:"Koff" }

  it "when a new beer with a name is created, it is added to the system" do
    visit new_beer_path
    # save_and_open_page
    fill_in('beer_name', with: 'TestBeer1')

    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
  end

  it "a new beer without a name is not created and an error message is shown" do
    visit new_beer_path
    click_button('Create Beer')

    expect(page).to have_content "Name can't be blank"
  end
end