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
        break if !valid?(move)
      
        # Execute move
        food = true if @@game_state.board[move.x][move.y] == GameConstants::FOOD
        @@game_state.board[move.x][move.y] = @@game_state.turn   # players ids on board are position in client array
      
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
    @@game_state.board[move.x][move.y] == GameConstants::BLANK
  end
  
  def handle_takes!
    begin
      takes = find_takes!
    end while taken
  end
  
  def find_takes!
    takes = []
    for i in board.size
      for j in board.first.size
        if is_player?(@@game_state.board[i][j])
          if surrounded?(i, j)
            # surrounder = get_surrounder(i, j)
            #          if surrounder == 
            #          @@game_state.board[i][j] = get_surrounder(i, j)
            #          takes << Move.new(i, j)
          end
        end
      end
    end
  end
  
  def is_player?(piece)
    piece >= 0
  end
  
  def surrounded?(x, y)
  end
  
  def get_surrounder(x, y)
  end
end
