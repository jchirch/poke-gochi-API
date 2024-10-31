class CreatePokemons < ActiveRecord::Migration[7.1]
  def change
    create_table :pokemons do |t|
      t.string :name, null: true
      t.string :description, null: true
      t.string :img_url, null: true
      t.string :cry_url, null: true
      t.string :small_img, null: true
      t.integer :level
      t.integer :xp
      t.integer :energy
      t.integer :max_energy
      t.integer :happiness

      t.timestamps
    end
  end
end
