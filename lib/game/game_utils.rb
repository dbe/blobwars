require './lib/game/game_state'

module GameUtils
  def self.valid?(game_state, move)
    return false if game_state.board[move.x][move.y] != GameConstants::BLANK
    return true if move.x + 1 < game_state.board.size && game_state.board[move.x + 1][move.y] == game_state.turn
    return true if move.x - 1 >= 0 && game_state.board[move.x - 1][move.y] == game_state.turn
    return true if move.y + 1 < game_state.board.first.size && game_state.board[move.x][move.y + 1] == game_state.turn
    move.y - 1 >= 0 && game_state.board[move.x][move.y - 1] == game_state.turn
  end
  
  def self.handle_takes!(game_state)
    handle_player_takes!(game_state)
    walls = find_takes(game_state, false)
    walls.map {|wall| game_state.board[wall.x][wall.y] = GameConstants::WALL}
  end
  
  def self.handle_player_takes!(game_state)
    begin
      takes = find_takes(game_state, true)
      takes.map {|take| game_state.board[take.x][take.y] = game_state.turn}
    end while takes.size > 0
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
          takes << Move.new(i, j) if surrounded?(game_state, i, j)
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
    
    -1.upto(1) do |i|
      -1.upto(1) do |j|
        c_x = x + i
        c_y = y + j
        next if c_x < 0 || c_x >= game_state.board.size
        next if c_y < 0 || c_y >= game_state.board.first.size
        player = game_state.board[c_x][c_y]
        if is_player?(player)
          counts[player] += 1
        end
      end  
    end
    
    max = 0
    counts.each_index do |i|
      next if i == game_state.board[x][y]
      max = counts[i] if counts[i] > max
    end
    
    max >= 4
  end
end
