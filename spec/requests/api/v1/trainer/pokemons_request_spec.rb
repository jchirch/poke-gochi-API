require 'rails_helper'

RSpec.describe 'Pokemon Endpoints' do
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
end