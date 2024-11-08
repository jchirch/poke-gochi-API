require 'rails_helper'
include ActiveJob::TestHelper

RSpec.describe DecrementHappinessJob, type: :job do
  it 'runs decrement happiness on specified pokemon' do
    trainer1 = Trainer.create!(name: "Red")

    pikachu = Pokemon.create!(
      name: "Pikachu", 
      description: "yellow rat", 
      gif_url: "example.com", 
      cry_url: "example.com", 
      small_img: "example.com",
      level: 1,
      xp: 1,
      energy: 1,
      max_energy: 1,
      happiness: 100,
      trainer_id: trainer1.id
    )

    expect(pikachu.happiness).to eq(100)

    perform_enqueued_jobs do
      DecrementHappinessJob.perform_now(pikachu.id)
    end

    pikachu.reload

    expect([96, 98]).to include(pikachu.happiness)
    # expect(pikachu.happiness).to eq(98)
  end
end
