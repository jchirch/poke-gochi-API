class Api::V1::Trainers::PokemonsController < ApplicationController
  def create
    pokemon_name = pokemon_params[:name]
    trainer_id = params[:trainer_id]
    begin
      pokemon = Pokemon.populate_with_api_data(pokemon_params, pokemon_name, trainer_id)
      if pokemon.save
        render json: PokemonSerializer.new(pokemon), status: :created
      else
        render json: ErrorSerializer.format_error(pokemon.errors, 422), status: :unprocessable_entity
      end
    rescue StandardError => e
      render json: ErrorSerializer.format_error(e, 422), status: :unprocessable_entity
    end
  end

  private 

  def pokemon_params
    params.permit(:name, :level, :xp, :energy, :max_energy, :happiness, :trainer_id)
  end

end

  def index
    begin
      trainer = Trainer.find(params[:trainer_id].to_i)
      pokemons = trainer.pokemons
    
      render json: PokemonSerializer.new(pokemons)
    rescue StandardError => exception
      render json: ErrorSerializer.format_error(exception, "404"), status: :not_found
    end
  end
end

