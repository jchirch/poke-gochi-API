require 'rails_helper'

RSpec.describe 'Pokemon Endpoints' do
  before (:each) do
    @trainer1 = Trainer.create!(name: "Red")
    @trainer2 = Trainer.create!(name: "Blue")
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
      @skitty = Pokemon.create!(name: "Skitty", 
      description: "pink cat", 
      gif_url: "example.com", 
      cry_url:  "example.com", 
      small_img:  "example.com",
      level: 1,
      xp: 1,
      energy: 1,
      max_energy: 1,
      happiness: 1,
      trainer_id: @trainer2.id)
    @beldum = Pokemon.create!(name: "Beldum", 
      description: "blue thing", 
      gif_url: "example.com", 
      cry_url:  "example.com", 
      small_img:  "example.com",
      level: 1,
      xp: 1,
      energy: 1,
      max_energy: 1,
      happiness: 1,
      trainer_id: @trainer2.id)
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

    it 'returns a specific pokemon for a specific trainer' do
      get "/api/v1/trainers/#{@trainer1.id}/pokemons/#{@pikachu.id}"

      expect(response).to be_successful
      pokemon = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(pokemon).to have_key(:id)
      expect(pokemon[:id]).to eq(@pikachu.id.to_s)
    end

    it "Updates Pokemon's attributes" do
      # /api/v1/trainers/:trainer_id/pokemons/:id(.:format)
      mew_id = @mew.id
      mew_before_energy = @mew.energy
      mew_before_happiness = @mew.happiness
      poke_params = {energy: 50, happiness: 75}

      patch "/api/v1/trainers/#{@trainer1.id}/pokemons/#{@mew.id}", params: poke_params

      updated_mew = Pokemon.find_by(id: mew_id)
      # require 'pry'; binding.pry
      expect(response).to be_successful

      expect(updated_mew.energy).to_not eq(mew_before_energy)
      expect(updated_mew.energy).to eq(50)

      expect(updated_mew.happiness).to_not eq(mew_before_happiness)
      expect(updated_mew.happiness).to eq(75)
    end
  end

  describe "Sad Paths" do
    it "Returns error with invalid request" do
      get "/api/v1/trainers/0/pokemons"
      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error = JSON.parse(response.body, symbolize_names: true)
      expect(error[:message]).to eq("404, Something went wrong")
    end

    it 'return an error message if pokemon belongs to another trainer' do
      get "/api/v1/trainers/#{@trainer1.id}/pokemons/#{@skitty.id}"

      expect(response).to_not be_successful
      expect(response.status).to eq(403)

      error = JSON.parse(response.body, symbolize_names: true)
      expect(error[:message]).to eq("403, Something went wrong")
      expect(error[:errors]).to eq("Pokemon does not belong to trainer")
    end

    it 'return an error message if pokemon doesnt exit in the database' do 
      get "/api/v1/trainers/#{@trainer1.id}/pokemons/0"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      error = JSON.parse(response.body, symbolize_names: true)
      expect(error[:message]).to eq("404, Something went wrong")
      expect(error[:errors]).to eq("Pokemon not in database")
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

    it "Updates Pokemon's attributes" do
      # /api/v1/trainers/:trainer_id/pokemons/:id(.:format)
      mew_id = @mew.id
      mew_before_energy = @mew.energy
      mew_before_happiness = @mew.happiness
      poke_params = {energy: 50, happiness: 75}

      patch "/api/v1/trainers/#{@trainer1.id}/pokemons/#{@mew.id}", params: poke_params

      updated_mew = Pokemon.find_by(id: mew_id)
      # require 'pry'; binding.pry
      expect(response).to be_successful

      expect(updated_mew.energy).to_not eq(mew_before_energy)
      expect(updated_mew.energy).to eq(50)

      expect(updated_mew.happiness).to_not eq(mew_before_happiness)
      expect(updated_mew.happiness).to eq(75)
    end
  end

  describe "Sad Paths" do
    it "Returns error with invalid request" do
      get "/api/v1/trainers/0/pokemons"
      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error = JSON.parse(response.body, symbolize_names: true)
      expect(error[:message]).to eq("404, Something went wrong")
    end

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
      expect(error_response[:message]).to eq("422, Something went wrong")
      expect(error_response[:errors]).to include("unexpected token at 'Not Found'")
    end

    xit "Returns error from invalid patch params" do
      mew_id = @mew.id
      mew_before_energy = @mew.energy
      mew_before_happiness = @mew.happiness
      poke_params = {energy: "potato", fake_attribute: 75}

      patch "/api/v1/trainers/#{@trainer1.id}/pokemons/#{@mew.id}", params: poke_params

      expect(response).to be_successful
      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(error_response).to have_key(:message)
      expect(error_response[:message]).to eq("422, result not found")
      expect(error_response[:errors]).to include("unexpected token at 'Not Found'")
    end
  end
end