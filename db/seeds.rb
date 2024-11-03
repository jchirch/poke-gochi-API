# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Trainer.create!(
    name: "Ash"
)
Trainer.create!(
    name: "Gary"
)

Pokemon.create!(
    name:"Gastly",
    description: "spooky boi",
    gif_url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/shiny/92.gif",
    cry_url: "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/92.ogg",
    small_img: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/92.png",
    level: 1,
    xp: 0,
    energy: 110,
    max_energy: 110,
    happiness: 100,
    trainer_id: 1
)

Pokemon.create!(
    name:"Charmander",
    description: "hot lil doggy",
    gif_url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/shiny/4.gif",
    cry_url: "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/4.ogg",
    small_img: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/4.png",
    level: 1,
    xp: 0,
    energy: 110,
    max_energy: 110,
    happiness: 100,
    trainer_id: 1
)

Pokemon.create!(
    name: "Magikarp",
    description: "In the distant past, it was somewhat stronger than the horribly weak descendants that exist today.",
    gif_url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/129.gif",
    cry_url: "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/129.ogg",
    small_img: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/129.png",
    level: 1,
    xp: 0,
    energy: 110,
    max_energy: 110,
    happiness: 100,
    trainer_id: 2
)

Pokemon.create!(
    name: "Shinx",
    description: "This Pokémon generates electricity by contracting\nits muscles. Excited trembling is a sign that Shinx\nis generating a tremendous amount of electricity.",
    gif_url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/shiny/403.gif",
    cry_url: "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/403.ogg",
    small_img: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/403.png",
    level: 5,
    xp:0,
    energy: 100,
    max_energy: 150,
    happiness: 80,
    trainer_id: 2
)