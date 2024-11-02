class Api::V1::Trainers::PokemonsController < ApplicationController
  def create
    pokemon_name = pokemon_params[:name]
    trainer_id = params[:trainer_id]
    pokemon = Pokemon.populate_with_api_data(pokemon_params, pokemon_name, trainer_id)
    pokemon.save!
    render json: PokemonSerializer.new(pokemon)
  end

  private 

  def pokemon_params
    params.permit(:name, :level, :xp, :energy, :max_energy, :happiness, :trainer_id)
  end

end
