class League < ActiveRecord::Base
  include ApplicationHelper
  include LeaguesHelper

  has_many :active_relationships, class_name: "LeagueTeamList",
                                  foreign_key: "league_id",
                                  dependent: :destroy
  has_many :games

  def game_days_and_times_for_ui
    day_list = {}
    GlobalConstants::DAYS.each do |day|
      if eval "self.#{day}"
        start_time = eval "self.#{day}_first_game"
        end_time = eval "self.#{day}_last_game"
        day_list.store(day, "#{start_time} to #{end_time}")
      end
    end
    day_list
  end

  def game_dates
    dates = []
    test_date = self.first_game_date
    while earlier?(test_date, self.last_game_date) == :day_1 or
          earlier?(test_date, self.last_game_date) == :same_day
      dates.push(test_date) if self.is_game_date(test_date)
      test_date = test_date+1
    end
    dates
  end

  def is_game_date(test_date)
    test_day_index = test_date.wday-1
    test_day = GlobalConstants::DAYS[test_day_index]
    if  ( earlier?(test_date, self.first_game_date) == :day_2 or
          earlier?(test_date, self.first_game_date) == :same_day ) and
        ( earlier?(test_date, self.last_game_date) == :day_1 or
          earlier?(test_date, self.last_game_date) == :same_day ) and
        self.game_days.include?(test_day)
      return true
    else
      return false
    end
  end

  def game_days
    days_list = []
    GlobalConstants::DAYS.each do |day|
      days_list.push(day) if eval "self.#{day}"
    end
    days_list
  end

  def teams
    list = []
    self.active_relationships.each do |relationship|
      list.push(Team.find(relationship.team_id))
    end
    list
  end

  def team_ids
    list = []
    self.active_relationships.each do |relationship|
      list.push(relationship.team_id)
    end
    list
  end

  def initialize_auto_schedule_round
    matchups = self.team_ids.permutation(2).to_a
    matchups.select! { |matchup| matchup[0] < matchup[1]}
    @matchups = Hash.new
    matchups.each do |matchup|
      matchup_count = get_matchup_count(matchup)
      @matchups.store(matchup, matchup_count)
    end
  end

  def concluded
    self.team_ids.each do |team_id|
      return false if Team.find(team_id).games.length < self.number_of_games
    end
    return true
  end

  def get_matchup_count(matchup)
    #a matchup is an array of [team_1_id, team_2_id]
    team_1 = Team.find(matchup[0])
    team_2_id = matchup[1]
    team_1.games(opponent: team_2_id, league: self.id).length
  end

  def get_matchups_to_schedule(matchups)
    #matchups is a hash in the form of:
    # { [team_1_id, team_2_id] => Fixnum number_of_matchups, ...}
    min_number = Float::INFINITY
    list = []
    matchups.each do |matchup, count|
      if count < min_number
        min_number = count
        list = [matchup]
      elsif count == min_number
        list.push(matchup)
      end
    end
    list
  end

  def get_pick(date, round)

    return :skip if concluded == true

    initialize_auto_schedule_round

    matchups = get_matchups_to_schedule(@matchups)
    matchups.sort! { |a,b| matchup_score(a) <=> matchup_score(b) }

    while matchups.length > 0
      matchup = matchups.shift.shuffle
      home_team_id = matchup[0]
      away_team_id = matchup[1]

      home_team_games = Team.find(home_team_id).games(date: date).length
      away_team_games = Team.find(away_team_id).games(date: date).length

      next if home_team_games >= round or away_team_games >= round

      requested_time_slots = acceptable_time_slots_list(home_team_id, away_team_id, date)
      while requested_time_slots.length > 0
        time_slot = requested_time_slots.shift
        field_id = field_available?(date, time_slot)
        if field_id != false
          return {date:      date,
                  field:     field_id,
                  time_slot: time_slot,
                  home_team: home_team_id,
                  away_team: away_team_id}
        end
      end
    end

    return :skip
  end

  def time_slots(date)
    day = GlobalConstants::DAYS[date.wday-1]
    first_game_slot = (eval "self.#{day}_first_game")
    last_game_slot =  (eval "self.#{day}_last_game")

    slots = GlobalConstants::GAME_START_TIMES.flatten.select do |time|
      time.class == Fixnum
    end

    slots.select do |time|
      time >= first_game_slot and time <= last_game_slot
    end

  end

  def any_standard_time_slots_remain?(dates = self.game_dates)
    dates.each do |date|
      self.time_slots(date).each do |slot|
        return true if field_available?(date, slot)
      end
    end
    return false
  end

  private

    def acceptable_time_slots_list(home_team, away_team, date)
      self.time_slots(date)
      #and then considerations for home and away team....
    end

    def matchup_score(matchup)
      #matchup = [home_team_id, away_team_id]
      home_team_score = Team.find(matchup[0]).games(league: self.id).length
      away_team_score = Team.find(matchup[1]).games(league: self.id).length

      home_team_score + away_team_score

    end
end
