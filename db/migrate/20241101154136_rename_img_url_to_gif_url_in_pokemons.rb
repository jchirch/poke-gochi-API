class RenameImgUrlToGifUrlInPokemons < ActiveRecord::Migration[7.1]
  def change
    rename_column :pokemons, :img_url, :gif_url
  end
end
