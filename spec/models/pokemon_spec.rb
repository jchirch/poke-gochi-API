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

    it 'validates uniqueness of name' do
      test_trainer = Trainer.create!(name: "Misty")
      Pokemon.create!(name: "Pikachu", description: "Electric type", gif_url: "example.com", cry_url: "example.com", small_img: "example.com", level: 1, xp: 1, energy: 1, max_energy: 1, happiness: 1, trainer_id: test_trainer.id)
      should validate_uniqueness_of(:name).with_message("Pokemon already exists, please choose new Pokemon.")
    end
  end
end