class CreateLeagueTeamLists < ActiveRecord::Migration
  def change
    create_table :league_team_lists do |t|
      t.integer :league_id
      t.integer :team_id
      t.timestamps null: false
    end
    add_index :league_team_lists, :league_id
    add_index :league_team_lists, :team_id
    add_index :league_team_lists, [:league_id, :team_id], unique: true
  end
end
