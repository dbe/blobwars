module GameUtils
  def valid?(game_state, move)
    game_state.board[move.x][move.y] == GameConstants::BLANK
    # TODO: add clause about needing to be adj to an existing, same-colored piece
  end
  
  def handle_takes!(game_state)
    begin
      takes = find_takes!
      # TODO process_takes!(takes)
    end while taken
  end
  
  def find_takes!(game_state)
    takes = []
    for i in board.size
      for j in board.first.size
        takes << Move.new(i, j) if is_player?(game_state.board[i][j]) && surrounded?(i, j)
      end
    end
    
    takes
  end
  
  def is_player?(piece)
    piece >= 0
  end
  
  def surrounded?(game_state, x, y)
    # TODO
  end
end