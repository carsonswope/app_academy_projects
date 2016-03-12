class Team < ActiveRecord::Base
  has_many :leagues,      class_name: "LeagueTeamList",
                          foreign_key: "team_id",
                          dependent: :destroy

  has_many :home_games,   class_name: "Game",
                          foreign_key: "team_1_id"

  has_many :away_games,   class_name: "Game",
                          foreign_key: "team_2_id"

  def games(options = {})
    list = []
    all_games = self.home_games + self.away_games
    all_games.each do |game|
      to_add = true
      if options[:date]
        to_add = false if game.game_date != options[:date]
      end

      if options[:opponent]
        if  !(game.team_1_id == options[:opponent] or
              game.team_2_id == options[:opponent] )
          to_add = false
        end
      end

      if options[:league]
        to_add = false if game.league_id != options[:league]
      end

      list.push(game.id) if to_add

    end
    list
  end

end
