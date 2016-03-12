module AutoScheduleHelper
  def schedule_first_round(league_list)
    all_game_dates(league_list).each do |game_date|
      leagues = requesting_leagues(game_date)
      pick_number = 1
      while place_pick(game_date, leagues, pick_number)
        pick_number += 1
      end
    end
  end

  def all_game_dates(league_list)
    #accepts an array of league id's
    #returns an array of days, in chronological order,
    #which is all of the game days for all the leagues
    all_dates = Hash.new
    league_list.each do |league_id|
      league = League.find(league_id)
      league.game_dates.each do |date|
        if all_dates[date]
          all_dates[date].push(league_id.to_i)
        else
          all_dates.store(date, [league_id.to_i])
        end
      end
    end
    all_dates
    #sort_earliest_dates_first(all_dates)
  end

  def serpentine_pick(pick_order, pick_number)
    #implements serpentine..
    first_team_index = 0
    last_team_index = pick_order.length-1

    mod = (pick_number-1) % ((last_team_index*2)+2)

    if mod <= pick_order.length-1
      return pick_order[mod]
    else
      return pick_order[((last_team_index*2)+1)-(mod)]
    end
  end
  
end
