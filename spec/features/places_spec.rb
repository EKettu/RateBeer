require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )
    allow(BeermappingApi).to receive(:weather_in).with("kumpula").and_return(nil
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if many are returned by the API, they are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("Helsinki").and_return(
      [Place.new( name:"Oljenkorsi", id: 1 ), Place.new( name:"Olvi", id: 2 ), Place.new( name:"Olki", id: 3 )  ]
    )
    allow(BeermappingApi).to receive(:weather_in).with("Helsinki").and_return(nil
    )

    visit places_path
    fill_in('city', with: 'Helsinki')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Olvi"
    expect(page).to have_content "Olki"
  end

  it "if none are returned by the API, a notice is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("Juankoski").and_return([]
    )
    allow(BeermappingApi).to receive(:weather_in).with("Juankoski").and_return(nil
      )

    visit places_path
    fill_in('city', with: 'Juankoski')
    click_button "Search"

    expect(page).to have_content "No locations in Juankoski"
  end
end