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
  end
end