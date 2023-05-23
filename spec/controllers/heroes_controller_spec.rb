require 'rails_helper'
require 'hero_factory'

RSpec.describe HeroesController, type: :controller do

    describe "GET #index" do
      it "returns a successful response" do
        get :index
        expect(response).to be_successful
      end
    end
  
    describe "GET #show" do
      hero = HeroFactory.create_hero
  
      it "returns a successful response" do
        get :show, params: { id: hero.id }
        expect(response).to be_successful
      end
  
      it "assigns the correct hero" do
        get :show, params: { id: hero.id }
        expect(assigns(:hero)).to eq(hero)
      end
    end
  
    describe "POST #create" do
      context "with valid attributes" do
        it "creates a new hero" do
          post :create, params: { hero: HeroFactory.valid_object }
          expect(response).to be_successful
        end
      end

      context "with invalid attributes" do
        it "creates a new hero" do
          post :create, params: { hero: HeroFactory.invalid_object }
          expect(response).to have_http_status(422)
        end
      end
  
      context "with incorrect argument" do
        it "does not create a new hero" do
          expect {
            post :create, params: { hero: HeroFactory.invalid_argument_object } 
          }.to raise_error(ArgumentError)
        end

      end
    end

    describe "PATCH #update" do
        hero = HeroFactory.create_hero
        
        context "with valid params" do
          let(:new_attributes) { { name: "Victor 2", attack: 150, defense: 70, life: 500 } }
    
          it "updates the requested user" do
            patch :update, params: { id: hero.id, hero: new_attributes }
            hero.reload
            expect(hero.name).to eq("Victor 2")
            expect(hero.attack).to eq(150)
          end

        end
    
        context "with invalid params" do
          it "renders the edit template" do
            expect {
              patch :update, params: { id: hero.id, hero: { name: nil, team: 0 } }
            }.to raise_error(ArgumentError)
          end
        end
    end
    
    describe "DELETE #destroy" do
        hero = HeroFactory.create_hero

        it "destroys the requested hero" do
          expect {
            delete :destroy, params: { id: hero.id }
          }.to change(Hero, :count).by(-1)
        end
    end 

end