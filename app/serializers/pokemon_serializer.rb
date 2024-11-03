class PokemonSerializer
  include JSONAPI::Serializer
  attributes  :name,
              :description,
              :gif_url,
              :cry_url,
              :small_img,
              :level,
              :xp,
              :energy,
              :max_energy,
              :happiness,
              :trainer_id
end

