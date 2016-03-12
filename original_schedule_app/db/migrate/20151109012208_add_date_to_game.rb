class AddDateToGame < ActiveRecord::Migration
  def change
    add_column :games, :game_date, :date
    add_index :games, :game_date
  end
end
