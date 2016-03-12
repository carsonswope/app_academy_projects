class Game < ActiveRecord::Base
  belongs_to :team, class_name: "team_1_id"
  belongs_to :team, class_name: "team_2_id"
  belongs_to :league
  belongs_to :field

  def info
    info =  { home_team: Team.find(self.team_1_id),
              away_team: Team.find(self.team_2_id),
              league: League.find(self.league_id),
              field: Field.find(self.field_id),
              time: self.game_time,
              date: self.game_date }
    info
  end

  def happens_before(other_game)

    if self.game_date.year  < other_game.game_date.year
      return true
    elsif self.game_date.year > other_game.game_date.year
      return false
    end

    if self.game_date.month  < other_game.game_date.month
      return true
    elsif self.game_date.month > other_game.game_date.month
      return false
    end

    if self.game_date.day  < other_game.game_date.day
      return true
    elsif self.game_date.day > other_game.game_date.day
      return false
    end

    if self.game_time
      if self.game_time  < other_game.game_time
        return true
      elsif self.game_time > other_game.game_time
        return false
      end
    end

    return false
  end
end
