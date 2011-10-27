class GameRunner
  def self.play(players, height, width)
    @@game_state = GameState.new(players, height, width)
    @@game_history = []
    
    # Put players on board
    # TODO
    
    while !@@game_state.over do
      # Get the player whose turn it is
      player = @@game_state.get_next_player
      
      begin
        # Player has not yet eaten
        food = false
        
        # Get client move
        move = player.get_move(@@game_state)
        
        @@game_history << Move.new(move.x, move.y)
      
        # Validate move
        break if !GameUtils.valid?(@@game_state, move)
      
        # Execute move
        food = true if @@game_state.board[move.x][move.y] == GameConstants::FOOD
        @@game_state.board[move.x][move.y] = @@game_state.turn   # players ids on board are position in client array
      
        # Handle any takes
        GameUtils::handle_takes!(@@game_state)
      end while food
      
      # Rotate turn
      @@game_state.rotate_turn!
    end
    
    # Write game to db
    # TODO
  end
  
end
