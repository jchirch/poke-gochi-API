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
  
   describe "Create/action" do 
    it 'creates a pokemon with the correct attributes and saves it to db' do 
      trainer = Trainer.create!(name: "Ash")
      pokemon_params = {
        name: "jolteon",
        description: "",
        gif_url: "",
        cry_url: "",
        small_img: "",
        level: 1,
        xp: 100,
        energy: 100,
        max_energy: 200,
        happiness: 100
      }

      post "/api/v1/trainers/#{trainer.id}/pokemons", params: pokemon_params
      
      new_pokemon = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
      
      expect(new_pokemon[:name]).to eq("jolteon")
      expect(new_pokemon[:level]).to eq(1)
      expect(new_pokemon[:xp]).to eq(100)
      expect(new_pokemon[:energy]).to eq(100)
      expect(new_pokemon[:max_energy]).to eq(200)
      expect(new_pokemon[:happiness]).to eq(100)
      expect(new_pokemon[:description]).to eq("It accumulates negative ions in the atmosphere to\fblast out 10000- volt lightning bolts.")
      expect(new_pokemon[:gif_url]).to eq("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/shiny/135.gif")
      expect(new_pokemon[:cry_url]).to eq("https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/135.ogg")
      expect(new_pokemon[:small_img]).to eq("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/135.png")
    end
   end

  describe 'create action sad path' do
    it 'returns an error if pokemon doesnt exist in the Pokeapi' do 
      trainer = Trainer.create!(name: "Ash")
      pokemon_params = {
        name: "dsfsdfsdf",
        description: "",
        gif_url: "",
        cry_url: "",
        small_img: "",
        level: 1,
        xp: 100,
        energy: 100,
        max_energy: 200,
        happiness: 100
      }

      post "/api/v1/trainers/#{trainer.id}/pokemons", params: pokemon_params

      expect(response).to have_http_status(:unprocessable_entity)

      error_response = JSON.parse(response.body, symbolize_names: true)
      
      expect(error_response).to have_key(:message)
      expect(error_response[:message]).to eq("422, result not found")
      expect(error_response[:errors]).to include("unexpected token at 'Not Found'")
    end
  end
end