class PokeApiService
  BASE_URL = "https://pokeapi.co/api/v2"

  def self.get_pokemon_species(pokemon_name)
    response = Faraday.get("#{BASE_URL}/pokemon-species/#{pokemon_name}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_pokemon_details(pokemon_name)
    response = Faraday.get("#{BASE_URL}/pokemon/#{pokemon_name}")
    JSON.parse(response.body, symbolize_names: true)
  end

end