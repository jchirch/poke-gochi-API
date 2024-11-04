class Pokemon < ApplicationRecord
  belongs_to :trainer
  after_create :start_happiness_decreaser 
  
    validates :name, presence: true, uniqueness: {message: "Pokemon already exists, please choose new Pokemon."}
    validates :description, presence: true
    validates :gif_url, presence: true
    validates :cry_url, presence: true
    validates :small_img, presence: true
    validates :level, presence: true, numericality: { message: "Level must be a number." }
    validates :xp, presence: true, numericality: { message: "XP must be a number." }
    validates :energy, presence: true, numericality: { message: "Energy must be a number." }
    validates :max_energy, presence: true, numericality: { message: "Max energy must be a number." }
    validates :happiness, presence: true, numericality: { message: "Happiness must be a number." }
    validates :trainer_id, presence: true, numericality: { message: "Trainer ID must be a number." }
    
  def self.populate_with_api_data(pokemon_params, pokemon_name, trainer_id)
    species_data = PokeApiService.get_pokemon_species(pokemon_name)
    details_data = PokeApiService.get_pokemon_details(pokemon_name)
    Pokemon.new(
      name: pokemon_params[:name],
      level: pokemon_params[:level],
      xp: pokemon_params[:xp],
      energy: pokemon_params[:energy],
      max_energy: pokemon_params[:max_energy],
      happiness: pokemon_params[:happiness],
      description: clean_description(species_data[:flavor_text_entries][0][:flavor_text]),
      gif_url: details_data[:sprites][:other][:showdown][:front_shiny],
      cry_url: details_data[:cries][:latest],
      small_img: details_data[:sprites][:front_default],
      trainer_id: trainer_id
    )
  end 

  def self.clean_description(description)
   description.gsub("\n", ' ').strip
  end

  def start_happiness_decreaser
    DecrementHappinessJob.perform_later(id)
  end
end
