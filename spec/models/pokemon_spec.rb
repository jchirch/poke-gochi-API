require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  describe 'Associations' do
    it { should belong_to(:trainer) }
  end

  describe 'Validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:gif_url)}
    it {should validate_presence_of(:cry_url)}
    it {should validate_presence_of(:small_img)}
    it {should validate_presence_of(:level)}
    it {should validate_presence_of(:xp)}
    it {should validate_presence_of(:energy)}
    it {should validate_presence_of(:max_energy)}
    it {should validate_presence_of(:happiness)}
    it {should validate_presence_of(:trainer_id)}

    it 'Validates uniqueness of name' do
      test_trainer = Trainer.create!(name: "Misty")
      Pokemon.create!(name: "Pikachu", description: "Electric type", gif_url: "example.com", cry_url: "example.com", small_img: "example.com", level: 1, xp: 1, energy: 1, max_energy: 1, happiness: 1, trainer_id: test_trainer.id)
      should validate_uniqueness_of(:name).with_message("Pokemon already exists, please choose new Pokemon.")
    end

    it 'Validates numericality of level' do
      test_trainer = Trainer.create!(name: "Misty")
      Pokemon.new(name: "Pikachu", description: "Electric type", gif_url: "example.com", cry_url: "example.com", small_img: "example.com", level: "potato", xp: 1, energy: 1, max_energy: 1, happiness: 1, trainer_id: test_trainer.id)
      should validate_numericality_of(:level).with_message("Level must be a number.")

    end

    it 'Validates numericality of xp' do
      test_trainer = Trainer.create!(name: "Misty")
      Pokemon.new(name: "Pikachu", description: "Electric type", gif_url: "example.com", cry_url: "example.com", small_img: "example.com", level: 1, xp: "potato", energy: 1, max_energy: 1, happiness: 1, trainer_id: test_trainer.id)
      should validate_numericality_of(:xp).with_message("XP must be a number.")
    end
    
    it 'Validates numericality of energy' do
      test_trainer = Trainer.create!(name: "Misty")
      Pokemon.new(name: "Pikachu", description: "Electric type", gif_url: "example.com", cry_url: "example.com", small_img: "example.com", level: 1, xp: 1, energy: "potato", max_energy: 1, happiness: 1, trainer_id: test_trainer.id)
      should validate_numericality_of(:energy).with_message("Energy must be a number.")
    end
    
    it 'Validates numericality of max_energy' do
      test_trainer = Trainer.create!(name: "Misty")
      Pokemon.new(name: "Pikachu", description: "Electric type", gif_url: "example.com", cry_url: "example.com", small_img: "example.com", level: 1, xp: 1, energy: 1, max_energy: "potato", happiness: 1, trainer_id: test_trainer.id)
      should validate_numericality_of(:max_energy).with_message("Max energy must be a number.")
    end
    
    it 'Validates numericality of happiness' do
      test_trainer = Trainer.create!(name: "Misty")
      Pokemon.new(name: "Pikachu", description: "Electric type", gif_url: "example.com", cry_url: "example.com", small_img: "example.com", level: 1, xp: 1, energy: 1, max_energy: 1, happiness: "potato", trainer_id: test_trainer.id)
      should validate_numericality_of(:happiness).with_message("Happiness must be a number.")
    end
    
    it 'Validates numericality of trainer_id' do
      test_trainer = Trainer.create!(name: "Misty")
      Pokemon.new(name: "Pikachu", description: "Electric type", gif_url: "example.com", cry_url: "example.com", small_img: "example.com", level: 1, xp: 1, energy: 1, max_energy: 1, happiness: 1, trainer_id: "potato")
      should validate_numericality_of(:trainer_id).with_message("Trainer ID must be a number.")
    end
    
  end
  
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

