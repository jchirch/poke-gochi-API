class Api::V1::PokemonsController < ApplicationController

  def index
    pokemons = Pokemon.all
    
  end

end