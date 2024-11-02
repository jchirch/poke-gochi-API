class PokemonsSerializer
  include JSONAPI::Serializer
  attributes :name, :level, :xp, :energy, :max_energy, :happiness

  def self.populate_attributes(data)
    require 'pry'; binding.pry
    Pokemon.create!(
      # description: data[:flavor_text_entries][0][:flavor_text],
      gif_url: data[:sprites][:other][:showdown][:front_shiny],
      cry_url: data[:cries][:latest],
      small_img: data[:sprites][:front_default]
    )
  end
end
