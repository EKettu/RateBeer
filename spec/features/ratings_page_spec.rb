require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryBot.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name:"Karhu", brewery:brewery }
  let!(:beer3) { FactoryBot.create :beer, name:"TestiOlut", brewery:brewery }
  let!(:user) { FactoryBot.create :user }
  let!(:user2) { FactoryBot.create :user2 }
  let!(:rating1) {FactoryBot.create :rating, user: user}
  let!(:rating2) {FactoryBot.create :rating, user: user}
  let!(:rating3) {FactoryBot.create :rating, user: user, beer:beer3}
  let!(:rating4) {FactoryBot.create :rating, user: user2, beer:beer1}
  let!(:rating5) {FactoryBot.create :rating, user: user2, beer:beer2}

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(5).to(6)

    expect(user.ratings.count).to eq(4)
    expect(beer1.ratings.count).to eq(2)
    expect(beer1.average_rating).to eq(9.5)
  end

  it "ratings are listed on the ratings page" do
    visit ratings_path
    expect(page).to have_content "List of ratings"
    # save_and_open_page
    expect(page).to have_content "anonymous 4"
    expect(page).to have_content "Number of ratings: 5"
  end

  it "user can see only his/her own ratings" do
    visit user_path(user)
    # save_and_open_page
    expect(page).to have_content "anonymous 4"
    expect(page).to have_no_content "iso 3"
    expect(page).to have_content "Has made 3 ratings"
  end

  it "when user deletes a rating, it is destroyed from the database" do
    visit user_path(user)
    # save_and_open_page
    expect{
        page.find('li', text: 'TestiOlut').click_link('delete')
      }.to change{Rating.count}.by(-1)
    expect(page).to have_no_content "TestiOlut"
  end

  it "user page shows user's favourite style" do
    visit user_path(user)
    expect(page).to have_content "Favorite style"
  end

  it "user page shows user's favourite brewery" do
    visit user_path(user)
    expect(page).to have_content "Favorite brewery"
  end
end
