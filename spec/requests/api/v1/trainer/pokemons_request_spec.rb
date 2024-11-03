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
      #  require 'pry'; binding.pry
      expect(response).to be_successful
      pokemons = JSON.parse(response.body, symbolize_names: true)
    end
  end

  describe "Sad Paths" do
    it "Returns error with invalid request" do
      get "/api/v1/trainers/0"
      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error = JSON.parse(response.body, symbolize_names: true)
      expect(error[:message]).to eq("404, result not found")
      expect(error[:errors]).to eq(["Couldn't find Trainer with 'id'=0"])
    end
  end
end