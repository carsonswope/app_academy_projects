class GamesController < ApplicationController
  include ApplicationHelper

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to leagues_path
    else
      redirect_to root_path
    end
  end

  private

    def game_params
      params.require(:game).permit( :league_id, :team_1_id,
                                    :team_2_id, :game_date,
                                    :game_time, :field_id )
    end
end
