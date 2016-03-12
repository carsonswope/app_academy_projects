class Field < ActiveRecord::Base
  include ApplicationHelper

  has_many :games

  def available?(date, time)
    # date of Date class. eg: Date.new(2015, 12, 25)
    # time is merely an integer..
    self.games.each do |game|
      return false if game.game_date == date and game.game_time == time
    end
    return true
  end
end
