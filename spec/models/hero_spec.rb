require 'rails_helper'

RSpec.describe 'Hero' do
  it "is valid with valid attributes" do
    hero = Hero.new(name: "Thanos", attack: 200, defense: 90, life: 500, team: 0)
    expect(hero).to be_valid
  end

  it "is invalid with an invalid attribute" do
    hero = Hero.new(name: "Thanos", attack: 200, defense: 90, life: "string", team: 0)
    expect(hero).to be_invalid
  end

  it "is invalid with an argument error" do
    expect { Hero.new(name: "Thanos", attack: 200, defense: 90, life: 500, team: 3) }.to raise_error(ArgumentError)
  end
end