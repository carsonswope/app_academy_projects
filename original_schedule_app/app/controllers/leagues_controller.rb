class LeaguesController < ApplicationController
  def new
    @league = League.new
  end

  def create
    @league = League.new(league_params)
    if @league.save
      redirect_to leagues_path
    else
      redirect_to new_league_path
    end
  end

  def index
    @leagues = League.all
    @league = League.new
  end

  def show
    @league = League.find(params[:id])
  end


  def edit

  end

  def destroy
    League.find(params[:id]).destroy
    redirect_to leagues_path
  end

  private

    def day_defined_params
      day_params = []
      GlobalConstants::DAYS.each do |day|
        day_params.push(day.to_sym)
        day_params.push("#{day}_first_game".to_sym)
        day_params.push("#{day}_last_game".to_sym)
      end
      day_params
    end

    def league_params
      params.require(:league).permit( :name,
                                      day_defined_params,
                                      :first_game_date,
                                      :last_game_date,
                                      :number_of_games,
                                      :method          )
    end

end
