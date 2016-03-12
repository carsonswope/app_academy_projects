class LeagueTeamListsController < ApplicationController
  def create
    @new_relationship = LeagueTeamList.new(list_params)
    if @new_relationship.save
      redirect_to teams_path
    else
      redirect_to root_path
    end
  end

  def destroy
    relationship = LeagueTeamList.find(params[:id])
    league = League.find(relationship.league_id)
    relationship.destroy
    redirect_to league
  end

  def show
  end

  private

    def list_params
      params.require(:league_team_list).permit(:team_id, :league_id)
    end
end
