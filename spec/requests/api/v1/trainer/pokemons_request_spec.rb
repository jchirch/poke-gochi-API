require 'rails_helper'

RSpec.describe 'Pokemon Endpoints' do
  before (:each) do
    @trainer1 = Trainer.create!(name: "Red")
    @pikachu = Pokemon.create!(name: "Pikachu", 
      description: "yellow rat", 
      gif_url: "example.com", 
      cry_url:  "example.com", 
      small_img:  "example.com",
      level: 1,
      xp: 1,
      energy: 1,
      max_energy: 1,
      happiness: 1,
      trainer_id: @trainer1.id)
    @mew = Pokemon.create!(name: "Mew", 
      description: "pink rat", 
      gif_url: "example.com", 
      cry_url:  "example.com", 
      small_img:  "example.com",
      level: 1,
      xp: 1,
      energy: 1,
      max_energy: 1,
      happiness: 1,
      trainer_id: @trainer1.id)                             
  end

  describe "Happy Paths" do
    it "Returns all of a trainer's pokemon #index" do
      get "/api/v1/trainers/#{@trainer1.id}/pokemons"

      expect(response).to be_successful
      pokemons = JSON.parse(response.body, symbolize_names: true)[:data]

      pokemons.each do |pokemon|
        expect(pokemon).to have_key(:id)
        expect(pokemon[:id]).to be_a(String)

        expect(pokemon).to have_key(:type)
        expect(pokemon[:type]).to eq("pokemon")

        attributes = pokemon[:attributes]

        expect(attributes).to have_key(:name)
        expect(attributes[:name]).to be_a(String)

        expect(attributes).to have_key(:description)
        expect(attributes[:description]).to be_a(String)

        expect(attributes).to have_key(:gif_url)
        expect(attributes[:gif_url]).to be_a(String)

        expect(attributes).to have_key(:cry_url)
        expect(attributes[:cry_url]).to be_a(String)

        expect(attributes).to have_key(:small_img)
        expect(attributes[:small_img]).to be_a(String)

        expect(attributes).to have_key(:level)
        expect(attributes[:level]).to be_a(Integer)

        expect(attributes).to have_key(:xp)
        expect(attributes[:xp]).to be_a(Integer)

        expect(attributes).to have_key(:energy)
        expect(attributes[:energy]).to be_a(Integer)

        expect(attributes).to have_key(:max_energy)
        expect(attributes[:max_energy]).to be_a(Integer)

        expect(attributes).to have_key(:happiness)
        expect(attributes[:happiness]).to be_a(Integer)

        expect(attributes).to have_key(:trainer_id)
        expect(attributes[:trainer_id]).to eq(@trainer1.id)
      end
    end
  end

  describe "Sad Paths" do
    it "Returns error with invalid request" do
      get "/api/v1/trainers/0/pokemons"
      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error = JSON.parse(response.body, symbolize_names: true)
      expect(error[:message]).to eq("404, result not found")
    end
  end
end