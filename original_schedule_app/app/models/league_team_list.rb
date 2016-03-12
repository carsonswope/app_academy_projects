class LeagueTeamList < ActiveRecord::Base
  belongs_to :team, class_name: "Team"
end
