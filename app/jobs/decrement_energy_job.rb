class DecrementEnergyJob < ApplicationJob
  queue_as :default

  def perform(pokemon_id)
    pokemon = Pokemon.find_by(id: pokemon_id)
    return unless pokemon
    return if pokemon.energy <= 0

    pokemon.decrement!(:energy, 2)

    self.class.set(wait: 30.minutes).perform_later(pokemon_id)
  end
end
