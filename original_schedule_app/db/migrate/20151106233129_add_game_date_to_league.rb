class AddGameDateToLeague < ActiveRecord::Migration
  def change
    add_column :leagues, :first_game_date, :date
    add_column :leagues, :last_game_date, :date
    add_column :leagues, :number_of_games, :integer
  end
end
