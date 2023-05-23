require 'rails_helper'
require 'hero_factory'

RSpec.describe 'Battle::Base' do
    hero1 = HeroFactory.create_hero("Hero1")
    hero2 = HeroFactory.create_hero("Hero2")

    result = Battle::Base.new(hero1, hero2).start_battle
    
    it "result should have valid attributes" do
        expect(result).to have_key(:battle)
        expect(result).to have_key(:turns)
        expect(result).to have_key(:winner)
    end

    it "turns should calculate correctly" do
        turns = result[:turns]

        turns.each do |turn|
            damage = turn[1][:attack_points] - turn[1][:defense_points]
            expect(damage).to eq(turn[1][:damage_dealt])
        end
    end  
    
end