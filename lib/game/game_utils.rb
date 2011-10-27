require './lib/game/game_state'

module GameUtils
  NUM_TO_TAKE = 4
  
  def self.valid?(game_state, move)
    # On board condition
    return false if move.x < 0 || move.x >= game_state.board.size
    return false if move.y < 0 || move.y >= game_state.board.first.size
    
    # Empty space condition
    return false if game_state.board[move.x][move.y] != GameConstants::BLANK
    
    # Adjacency condition
    player_is_up_down_right_or_left?(game_state, move)
  end
  
  def self.handle_takes!(game_state)
    begin
      takes = handle_player_takes!(game_state, true)
    end while takes.size > 0
    
    handle_player_takes!(game_state, false)
  end
  
  def self.handle_player_takes!(game_state, current_player)
    takes = find_takes(game_state, current_player)
    takes.map {|take| game_state.apply_move(take.x, take.y, current_player ? game_state.turn : GameConstants::WALL)}
    takes
  end
  
  def self.find_takes(game_state, current_player)
    # current_player: whether or not we're looking for
    # the takes of the player whose turn it is
    takes = []
    board = game_state.board
    board.each_index do |i|
      board.first.each_index do |j|
        if is_player?(board[i][j]) 
          next if current_player && board[i][j] == game_state.turn
          takes << Coordinate.new(i, j) if surrounded?(game_state, i, j)
        end
      end
    end
    
    takes
  end
  
  def self.is_player?(tile)
    tile >= 0
  end
  
  def self.surrounded?(game_state, x, y)
    counts = [0] * game_state.players.size
    player = game_state.board[x][y]
    
    -1.upto(1) do |i|
      -1.upto(1) do |j|
        surrounding_player = game_state.board[(x + i) % game_state.board.size][(y + j) % game_state.board.first.size]
        counts[surrounding_player] += 1 if is_player?(surrounding_player) && player != surrounding_player
      end  
    end

    counts.each.max >= NUM_TO_TAKE
  end
  
  def self.player_is_up_down_right_or_left?(game_state, move)
    game_state.board[(move.x + 1) % game_state.board.size][move.y] == game_state.turn ||
    game_state.board[(move.x - 1) % game_state.board.size][move.y] == game_state.turn ||
    (game_state.board[move.x][(move.y + 1) % game_state.board.first.size] == game_state.turn) ||
    (game_state.board[move.x][(move.y - 1) % game_state.board.first.size] == game_state.turn)
  end
end
