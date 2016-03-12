class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :league_id
      t.integer :team_1_id
      t.integer :team_2_id
      t.integer :game_time
      t.integer :field_id
      t.timestamps null: false
    end
    add_index :games, :league_id
    add_index :games, :team_1_id
    add_index :games, :team_2_id
    add_index :games, :field_id
  end
end
