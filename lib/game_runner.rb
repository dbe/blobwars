class GameRunner
  def self.play(players, height, width)
    @@game_state = GameState.new(players, height, width)
    
    while !@@game_state.over do
      # Decide whose turn it is
      @@game_state.rotate_turn! unless game_state.player_ate?
      player = @@game_state.get_next_player
      
      # Get client move
      move = player.get_move(@@game_state)  
      
      # Validate move
      if valid?(move)
        # Execute move
        @@game_state.board[y][x] = turn   # players ids on board are position in client array
      end
    end
  end
  
  private
  
  def game_over?(game)
    # TODO
    true
  end
  
  def valid?(move)
    @@game_state.board[move.y][move.x] == GameConstants::BLANK
  end
  
end
