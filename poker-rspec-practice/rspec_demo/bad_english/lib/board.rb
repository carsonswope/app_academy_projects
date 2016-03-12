class Chess
  def play_game
    until game_is_over?
      ask_current_player_for_turn
      make_move_on_board
      switch_players
    end
  end
end
