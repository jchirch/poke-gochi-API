require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  describe '.populate_with_api_data' do
    it 'creates a Pokemon with the correct attributes' do
      pokemon_name = "charmander"
      trainer = Trainer.create!(name: "Ash")
      pokemon_params = {
        name: "charmander",
        level: 1,
        xp: 100,
        energy: 100,
        max_energy: 200,
        happiness: 100
      }
      pokemon = Pokemon.populate_with_api_data(pokemon_params, pokemon_name, trainer.id)

      expect(pokemon.name).to eq("charmander")
      expect(pokemon.level).to eq(1)
      expect(pokemon.xp).to eq(100)
      expect(pokemon.energy).to eq(100)
      expect(pokemon.max_energy).to eq(200)
      expect(pokemon.happiness).to eq(100)
      expect(pokemon.description).to be_a(String)
      expect(pokemon.gif_url).to be_a(String)
      expect(pokemon.cry_url).to be_a(String)
      expect(pokemon.small_img).to be_a(String)
      expect(pokemon.trainer_id).to eq(trainer.id)
    end
  end
end
