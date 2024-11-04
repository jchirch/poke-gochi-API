require 'rails_helper'

RSpec.describe 'Trainer Endpoints' do
  before (:each) do
    @trainer1 = Trainer.create!(name: "Ash")
  end

  describe 'Happy paths' do
    it 'returns trainer based on id' do
      get "/api/v1/trainers/#{@trainer1.id}"
      expect(response).to be_successful
      trainer = JSON.parse(response.body, symbolize_names: true)

      expect(trainer[:data][:id]).to eq(@trainer1.id.to_s)
      expect(trainer[:data][:attributes][:name]).to eq(@trainer1.name)
      expect(trainer[:data][:type]).to eq("trainer")
    end
  end

  describe 'Sad paths' do
    it 'returns error with invalid request' do
      get "/api/v1/trainers/0"
      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error = JSON.parse(response.body, symbolize_names: true)
      expect(error[:message]).to eq("404, Something went wrong")
      expect(error[:errors]).to eq(["Couldn't find Trainer with 'id'=0"])
    end
  end
end