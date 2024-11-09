# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

trainer = Trainer.create!(
    name: "Ash"
)

Pokemon.create!(
    name:"Bulbasaur",
    description: "For some time after its birth, it grows by gaining nourishment from the seed on its back.",
    gif_url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/1.gif",
    cry_url: "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/1.ogg",
    small_img: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
    level: 1,
    xp: 0,
    energy: 110,
    max_energy: 110,
    happiness: 100,
    trainer_id: trainer.id
)

Pokemon.create!(
    name:"Charmander",
    description: "The fire on the tip of its tail is a measure of its life. If healthy, its tail burns intensely",
    gif_url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/4.gif",
    cry_url: "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/4.ogg",
    small_img: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png",
    level: 1,
    xp: 0,
    energy: 110,
    max_energy: 110,
    happiness: 100,
    trainer_id: trainer.id
)

Pokemon.create!(
    name:"Squirtle",
    description: "It shelters itself in its shell then strikes back with spouts of water at every opportunity.",
    gif_url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/7.gif",
    cry_url: "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/7.ogg",
    small_img: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png",
    level: 1,
    xp: 0,
    energy: 110,
    max_energy: 110,
    happiness: 100,
    trainer_id: trainer.id
)
