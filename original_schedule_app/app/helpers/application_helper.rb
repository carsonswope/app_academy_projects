module ApplicationHelper
  def get_games_list(schedule_request)
    league = schedule_request[:league] || nil
    team = schedule_request[:team] || nil
    field = schedule_request[:field] || nil

    list = []
    Game.all.each { |game| list.push(game)}

    if league
      list.delete_if { |game| game.league_id != league }
    end

    if team
      list.delete_if do |game|
        game.team_1_id != team and game.team_2_id != team
      end
    end

    if field
      list.delete_if { |game| game.field_id != field }
    end

    sort_earliest_games_first(list)

  end

  def sort_earliest_games_first(games_list)
    list = games_list.dup
    out_of_order = true
    while out_of_order == true
      out_of_order = false
      0.upto(list.length-2) do |i|
        if list[i+1].happens_before(list[i])
          out_of_order = true
          list[i+1], list[i] = list[i], list[i+1]
        end
      end
    end
    list
  end

  def sort_earliest_dates_first(dates_list)
    list = dates_list.dup
    out_of_order = true
    while out_of_order == true
      out_of_order = false
      0.upto(list.length-2) do |i|
        if  Game.new(game_date: list[i+1]).happens_before(
            Game.new(game_date: list[i]))
          out_of_order = true
          list[i+1], list[i] = list[i], list[i+1]
        end
      end
    end
    list
  end

  def earlier?(d_1, d_2)
    numerical_dates = Hash.new

    [d_1, d_2].each do |date|

      year = date.year.to_s
      while year.length < 4
        year = "0#{year}"
      end

      month = date.month.to_s
      while month.length < 2
        month = "0#{month}"
      end

      day = date.day.to_s
      while day.length < 2
        day = "0#{day}"
      end

      number = "#{year}#{month}#{day}".to_i
      numerical_dates.store(date, number)

    end

    if numerical_dates[d_1] < numerical_dates[d_2]
      return :day_1
    elsif numerical_dates[d_1] > numerical_dates[d_2]
      return :day_2
    else
      return :same_day
    end
  end

  def print_date(date)
    date.day
    date.year
    "#{date.month}/#{date.day}/#{date.year}"
  end

  def print_day(date)
    GlobalConstants::PRINT_DAYS[date.wday]
  end

  def print_time(time)
    time_string = time.to_s
    if time_string.length == 4
      minutes = time_string[2..3]
      hours = time_string[0..1]
    else
      minutes = time_string[1..2]
      hours = time_string[0]
    end

    if hours.to_i > 12
      hours = (hours.to_i-12).to_s
      time_type = "PM"
    else
      time_type = "AM"
    end

    "#{hours}:#{minutes} #{time_type}"
  end

  def field_available?(date, time_slot)
    Field.all.each do |field|
       return field.id if field.available?(date, time_slot)
    end
    return false
  end

end
