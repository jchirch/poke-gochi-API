require 'rails_helper'

RSpec.describe 'Pokemon Endpoints' do
  describe "PokeApiService" do 
    it 'returns pokemon details' do 
      response = PokeApiService.get_pokemon_details('pikachu')
      require 'pry'; binding.pry
    end
  end
end