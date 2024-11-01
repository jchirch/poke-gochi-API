require 'rails_helper'

RSpec.describe 'Trainer Endpoints' do
  before (:each) do
    @trainer1 = Trainer.create!(name: "Ash")
  end

  it 'returns trainer based on id' do
    get "/api/v1/trainers/#{@trainer1.id}"
    expect(response).to be_successful
    trainer = JSON.parse(response.body, symbolize_names: true)
    # require 'pry'; binding.pry
    expect(trainer[:data][:id]).to eq(@trainer1.id.to_s)
    expect(trainer[:data][:attributes][:name]).to eq(@trainer1.name)
    expect(trainer[:data][:type]).to eq("trainer")

  end
  
end