class GameRunner
  def self.play(players, height, width)
    @@game_state = GameState.new(players, height, width)
    
    while !@@game_state.over do
      # Get the player whose turn it is
      player = @@game_state.get_next_player
      
      begin
        # Player has not yet eaten
        food = false
        
        # Get client move
        move = player.get_move(@@game_state)  
      
        # Validate move
        next if !valid?(move)
      
        # Execute move
        food = true if @@game_state.board[y][x] == GameConstants::FOOD
        @@game_state.board[y][x] = turn   # players ids on board are position in client array
      
        # Handle any takes
        handle_takes!
      
        # Rotate turn
        @@game_state.rotate_turn!
      end while food        # while the 
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
  
  def handle_takes!
    # TODO
  end
end
