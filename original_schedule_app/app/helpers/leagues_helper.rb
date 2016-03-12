module LeaguesHelper

  def game_days_and_times_for_ui(league)
    day_list = {}
    GlobalConstants::DAYS.each do |day|
      if eval "league.#{day}"
        start_time = eval "league.#{day}_first_game"
        end_time = eval "league.#{day}_last_game"
        day_list.store(day, "#{start_time} to #{end_time}")
      end
    end
    day_list
  end

  def member_team_ids(league)
    teams = []
    league.active_relationships do |relationship|
      teams.push(relationship.team_id)
    end
    teams
  end
end
