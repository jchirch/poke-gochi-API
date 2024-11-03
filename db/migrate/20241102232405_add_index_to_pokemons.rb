class AddIndexToPokemons < ActiveRecord::Migration[7.1]
  def change
    add_index :pokemons, :name
    add_index :pokemons, :id
  end
end
