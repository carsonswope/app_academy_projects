module GlobalConstants
  DAYS = [ :mon, :tues, :weds, :thurs, :fri, :sat, :sun]
  MAX_REQUEST_INDEX = 9
  GAME_START_TIMES = [["6:25 PM", 1825], ["7:15 PM", 1915],
                      ["8:05 PM", 2005], ["8:55 PM", 2055],
                      ["9:50 PM", 2150], ["10:40 PM", 2240]]
  FIELD_TYPES = [["full court", :full], ["3v3 court", :half]]

  PRINT_DAYS = ["", "MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
  def get_games_list(schedule_request)
    Game.all
  end

  DATE_COMPARISON_OPERATORS =
      { before_or_equal:  Proc.new { |d_1, d_2| d_1 <= d_2 },
        before:           Proc.new { |d_1, d_2| d_1 < d_2 },
        after_or_equal:   Proc.new { |d_1, d_2| d_1 >= d_2 },
        after:            Proc.new { |d_1, d_2| d_1 > d_2 } }

end
