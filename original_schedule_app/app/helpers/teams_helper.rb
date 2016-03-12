module TeamsHelper
  include ApplicationHelper
  include AutoScheduleHelper

  def request_data(number, team)
    hash = Hash.new
    start = "day_req_#{number}"
    hash.store(:valid_request, (eval "team.#{start}"))
    type = (eval "team.#{start}_before_after") ? "before" : "after"
    hash.store(:req_type, type)
    hash.store(:date, (eval "team.#{start}_date"))
    hash.store(:time, (eval "team.#{start}_time"))
    hash
  end

  def list_of_non_member_leagues(team = nil)
    leagues = League.all
    list = []
    leagues.each do |league|
      list.push([league.name, league.id]) unless
      team.leagues.find_by(league_id: league.id)
    end
    list
  end

  def leagues_currently_in(team)
    list = []
    team.leagues.each do |relationship|
      list.push(relationship.league_id)
    end
    list
  end
end
