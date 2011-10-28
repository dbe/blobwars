require './lib/game/game_state'

module GameUtils
  def self.valid?(game_state, move)
    return false if move.x < 0 || move.x >= game_state.board.size || move.y < 0 || move.y >= game_state.board.first.size
    return false if game_state.board[move.x][move.y] != GameConstants::BLANK
    return true if move.x + 1 < game_state.board.size && game_state.board[move.x + 1][move.y] == move.team
    return true if move.x - 1 >= 0 && game_state.board[move.x - 1][move.y] == move.team
    return true if move.y + 1 < game_state.board.first.size && game_state.board[move.x][move.y + 1] == move.team
    move.y - 1 >= 0 && game_state.board[move.x][move.y - 1] == move.team
    
    
  end
  
  def self.handle_takes!(game_state)
    handle_player_takes!(game_state)
    walls = find_takes(game_state, false)
    walls.map {|wall| game_state.apply_move(wall.x, wall.y, GameConstants::WALL)}
  end
  
  def self.handle_player_takes!(game_state)
    begin
      takes = find_takes(game_state, true)
      takes.map {|take| game_state.apply_move(take.x, take.y, game_state.current_player)}
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
          next if current_player && board[i][j] == game_state.current_player
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
    counts = {}
    counts.default = 0
    team = game_state.board[x][y]
    
    -1.upto(1) do |i|
      -1.upto(1) do |j|
        c_x = x + i
        c_y = y + j
        next if c_x < 0 || c_x >= game_state.board.size
        next if c_y < 0 || c_y >= game_state.board.first.size
        surrounding_team = game_state.board[c_x][c_y]
        if is_player?(surrounding_team) && team != surrounding_team
          counts[surrounding_team] += 1
        end
      end  
    end

    !counts.empty? && counts.each_value.max >= 4
  end
end
