require 'rails_helper'

RSpec.describe Trainer, type: :model do
  describe 'Associations' do
    it { should have_many(:pokemons) }
  end
  describe 'Validations' do
    it {should validate_presence_of (:name)}
  end
end
