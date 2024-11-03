class Api::V1::Trainers::PokemonsController < ApplicationController
  def create
    pokemon_name = pokemon_params[:name]
    trainer_id = params[:trainer_id]
    begin
      pokemon = Pokemon.populate_with_api_data(pokemon_params, pokemon_name, trainer_id)
      render json: PokemonSerializer.new(pokemon), status: :created if pokemon.save
    rescue StandardError => e
      render json: ErrorSerializer.format_general_error(e, 422), status: :unprocessable_entity
    end
  end

  def index
    begin
      trainer = Trainer.find(params[:trainer_id].to_i)
      pokemons = trainer.pokemons
    
      render json: PokemonSerializer.new(pokemons)
    rescue StandardError => exception
      render json: ErrorSerializer.format_general_error(exception, "404"), status: :not_found
    end
  end

  def show
    trainer = Trainer.find(params[:trainer_id].to_i)
    pokemon = Pokemon.find_by(id: params[:id].to_i)
    if pokemon.nil?
      render json: ErrorSerializer.format_specific_error("Pokemon not in database", '404'), status: :not_found
    elsif pokemon.trainer_id != trainer.id
      render json: ErrorSerializer.format_specific_error("Pokemon does not belong to trainer", '403'), status: :forbidden
    else
      render json: PokemonSerializer.new(pokemon)
    end
  end

  private 

  def pokemon_params
    params.permit(:name, :level, :xp, :energy, :max_energy, :happiness, :trainer_id)
  end
end

