class Api::V1::PokemonsController < ApplicationController
  def show
    begin
      pokemon_name = params[:name] 
      species_data = PokeApiService.get_pokemon_species(pokemon_name)
      details_data = PokeApiService.get_pokemon_details(pokemon_name)
      require 'pry'; binding.pry

      pokemon = PokemonsSerializer.populate_attributes(details_data)
      render json: PokemonsSerializer.new(pokemon)
    rescue StandardError => e
      render json: { error: e.message }, status: :bad_request
    end
  end
end