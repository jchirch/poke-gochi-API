require 'rails_helper'
include ActiveJob::TestHelper

RSpec.describe DecrementEnergyJob, type: :job do
  it 'runs decrement energy on specified pokemon' do
    trainer1 = Trainer.create!(name: "Red")

    pikachu = Pokemon.create!(
      name: "Pikachu", 
      description: "yellow rat", 
      gif_url: "example.com", 
      cry_url: "example.com", 
      small_img: "example.com",
      level: 1,
      xp: 1,
      energy: 100,
      max_energy: 1,
      happiness: 1,
      trainer_id: trainer1.id
    )

    expect(pikachu.energy).to eq(100)

    perform_enqueued_jobs do
      DecrementHappinessJob.perform_later(pikachu.id)
    end

    pikachu.reload

    expect(pikachu.energy).to eq(98)
  end
end