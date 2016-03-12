class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def edit
    @team = Team.find(params[:id])
  end

  def show
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(team_params)
      redirect_to teams_path
    else
      redirect_to teams_path
    end
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to teams_path
    else
      redirect_to new_team_path
    end
  end

  def index
    @teams = Team.all
    @add_team_to_league = LeagueTeamList.new
  end

  def destroy
    Team.find(params[:id]).destroy
    redirect_to teams_path
  end

  private

    def req_params
      list = []
      0.upto(9) do |req_num|
        start = "day_req_#{req_num.to_s}"
        list.push(start.to_sym)
        list.push("#{start}_before_after".to_sym)
        list.push("#{start}_time".to_sym)
        list.push("#{start}_date".to_sym)
      end
      list
    end

    def team_params
      params.require(:team).permit( :name, :email, :phone_number,
                                    :contact_name, :before_req,
                                    :before_req_time, :after_req,
                                    :after_req_time, req_params)
    end
end
