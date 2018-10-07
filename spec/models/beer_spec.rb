require 'rails_helper'

RSpec.describe Beer, type: :model do

  it "is not saved without a name" do
    test_brewery = Brewery.new name: "test", year: 2000 
    test_style =  Style.new name: "IPA", description: "okay"
    beer = Beer.create style: test_style, brewery:test_brewery

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    test_brewery = Brewery.new name: "test", year: 2000 
    beer = Beer.create name:"Lapin kulta", brewery:test_brewery

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  describe "with all fields correctly set" do
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }
    let(:style) { Style.new name: "Lager", description: "okay" }
    let(:beer){ Beer.create name:"Olvi", style: style, brewery:test_brewery }

    it "is saved" do
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  end
end
