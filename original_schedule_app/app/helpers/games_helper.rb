module GamesHelper
  include ApplicationHelper

  def list_of_leagues
    list = []
    League.all.each do |league|
      list.push([league.name, league.id])
    end
    list
  end

  def list_of_teams
    list = []
    Team.all.each do |team|
      list.push([team.name, team.id])
    end
    list
  end

  def list_of_fields
    list = []
    Field.all.each do |field|
      list.push([field.name, field.id])
    end
    list
  end

end
