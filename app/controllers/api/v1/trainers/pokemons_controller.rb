class Api::V1::Trainers::PokemonsController < ApplicationController

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