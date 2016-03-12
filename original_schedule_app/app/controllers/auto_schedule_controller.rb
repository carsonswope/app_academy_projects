class AutoScheduleController < ApplicationController
  include AutoScheduleHelper
  include ApplicationHelper

  def home
    @leagues = League.all
  end

  def execute
    @leagues_to_schedule = make_list_of_leagues(request_params) #ApplicationHelper
    @game_dates = all_game_dates(@leagues_to_schedule) #AutoScheduleHelper

    round = 1

    ##FIRST ROUND
    while first_round_concluded?(@leagues_to_schedule) == false

      game_dates_earliest_first(@game_dates).each do |date|
        pick_number = 1
        pick_order = @game_dates[date].shuffle
        original_pick_order = pick_order.dup

        while requests_remaining?(pick_order)
          picking_league_id = serpentine_pick(original_pick_order, pick_number)
          picking_league = League.find(picking_league_id)
          pick = picking_league.get_pick(date, round)
          if pick == :skip
            i = original_pick_order.index(picking_league_id)
            pick_order[i] = :skip
          else
            schedule_game(pick, picking_league_id)
          end
          pick_number += 1
        end
      end
      round += 1
    end


    ##SECOND ROUND
    @leagues_remaining = get_not_fully_scheduled_leagues(@leagues_to_schedule)
    leagues_remaining = @leagues_remaining.dup
    @reschedules = Hash.new

    pick_number = 1

    while still_hoping_to_pick(leagues_remaining)
      league_id = serpentine_pick(@leagues_remaining, pick_number)
      game_date = @game_dates.each_key.to_a.shuffle.first
      #all_dates = @game_dates.each_key.to_a.shuffle
      #all_dates.each do |game_date|
      league = League.find(league_id)
      possible_trade_leagues = get_possible_trade_leagues(@leagues_to_schedule, league_id, game_date)
      possible_trade_leagues.each { |league_id| @reschedules.store(league_id, 0) if @reschedules[league_id].nil?}
      reschedule_made = false

      while possible_trade_leagues.length > 0 and reschedule_made == false
        #trade_league_id = get_least_rescheduled_league(possible_trade_leagues, @reschedules)
        trade_league_id = possible_trade_leagues.sort { |a,b| @reschedules[a] <=> @reschedules[b] }.first
        trade_league = League.find(trade_league_id)

        available_slots = trade_league.time_slots(game_date).select do |slot|
          field_available?(game_date, slot)
        end

        intersection = intersecting_time_slots(league_id, trade_league_id, game_date)

        old_game_time = intersection.shuffle.pop
        new_game_time = available_slots.shuffle.pop

        game_id = get_game(game_date, old_game_time, trade_league_id)
        if game_id != nil
          reschedule_game(game_id, new_time: new_game_time) unless league.concluded

          pick = league.get_pick(game_date, round + 1000)
          if pick != :skip
            schedule_game(pick, league.id)
            reschedule_made = true
            @reschedules[trade_league_id] += 1
          end
        end
      end
      pick_number += 1
    end

  end

  private

    def still_hoping_to_pick(leagues_remaining)
      leagues_remaining.each do |league_id|
        if League.find(league_id).concluded == false
          if get_all_possible_trade_leagues(@leagues_to_schedule, league_id).length > 0
            return true
          end
        end
      end
      return false
    end

    def get_all_possible_trade_leagues(leagues_list, league_id)
      list = []
      league = League.find(league_id)
      league.game_dates.each do |date|
        list.push(get_possible_trade_leagues(leagues_list, league_id, date))
      end
      list
    end

    def get_possible_trade_leagues(leagues_list, league_id, date)
      league = League.find(league_id)
      @leagues_to_schedule.select do |trade_league_id|
        trade_league = League.find(trade_league_id)
        intersecting_time_slots = trade_league.time_slots(date) & league.time_slots(date)

        trade_league.any_standard_time_slots_remain?([date]) and
        intersecting_time_slots.length > 0
      end
    end

    def reschedule_game(game_id, options = {})
      game = Game.find(game_id)
      game.game_time = options[:new_time] if options[:new_time]
      game.save
    end

    def get_game(game_date, old_game_time, trade_league_id)
      league = League.find(trade_league_id)
      games = league.games.select do |game|
        game.game_time == old_game_time and
        game.game_date == game_date
      end

      if games.length > 0
        games.shuffle.pop.id
      else
        nil
      end

    end

    def intersecting_time_slots(league_1_id, league_2_id, date)
      league_1 = League.find(league_1_id)
      league_2 = League.find(league_2_id)
      league_1.time_slots(date) & league_2.time_slots(date)
    end

    def get_not_fully_scheduled_leagues(leagues_to_schedule)
      leagues_to_schedule.select do |league_id|
        league = League.find(league_id)
        league.any_standard_time_slots_remain? == false and
        league.concluded == false
      end
    end

    def first_round_concluded?(leagues_list)
      #first half regarding if all leagues have scheduled all
      #the necessary games
      still_picking = []
      leagues_list.each do |league_id|
        league = League.find(league_id)
        if  league.concluded == false and
            league.any_standard_time_slots_remain? == true
          still_picking.push(league_id)
        end
      end

      if still_picking.length > 0
        return false
      else
        return true
      end
    end

    def schedule_game(pick, picking_league_id)

      game = Game.new(  league_id: picking_league_id,
                        team_1_id: pick[:home_team],
                        team_2_id: pick[:away_team],
                        game_time: pick[:time_slot],
                        field_id:  pick[:field],
                        game_date: pick[:date] )
      game.save unless pick[:away_team].nil?
    end

    def requests_remaining?(pick_order)
      pick_order.each do |pick|
        return true if pick != :skip
      end

      return false
    end

    def all_requests(date, league_ids_list)
      requests = Hash.new
      @all_requests = Hash.new
      league_ids_list.each do |league_id|
        league_pick = League.find(league_id).get_pick(date)
        requests.store(league_id, league_pick)
      end
      requests
    end

    def request_params
      params.require(:auto_schedule_request)
    end

    def make_list_of_leagues(params)
      list = []
      params.each do |param|
        list.push(param[0]) if param[1] == "1"
      end
      list
    end

    def game_dates_earliest_first(game_dates_hash)
      list = []
        game_dates_hash.each_key do |date|
        list.push(date)
      end
      sort_earliest_dates_first(list)
    end

end
