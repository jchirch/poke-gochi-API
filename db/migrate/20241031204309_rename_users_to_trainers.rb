class RenameUsersToTrainers < ActiveRecord::Migration[7.1]
  def change
    rename_table :users, :trainers
    rename_column :pokemons, :user_id, :trainer_id
  end
end
