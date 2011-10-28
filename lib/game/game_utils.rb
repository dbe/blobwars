require './lib/game/game_state'

module GameUtils
  NUM_TO_TAKE = 4
  
  def self.find_winners(game_state)
    scores = Hash.new
    scores.default = 0
    # Count the number of tiles for each player
    game_state.board.each do |col|
      col.each do |player_id|
        scores[player_id] += 1 if player_id != GameConstants::BLANK && player_id != GameConstants::WALL
      end
    end
    
    max = scores.values.each.max
    scores.reject {|k,v| v != max}.keys
  end
  
  def self.valid?(game_state, move)
    # On board condition
    return false if move.x < 0 || move.x >= game_state.board.size
    return false if move.y < 0 || move.y >= game_state.board.first.size
    
    # Empty space condition
    return false if game_state.board[move.x][move.y] != GameConstants::BLANK
    
    # Adjacency condition
    player_is_up_down_right_or_left?(game_state, move)
  end
  
  def self.handle_takes!(game_state, turn)
    begin
      takes = handle_player_takes!(game_state, turn, true)
    end while takes.size > 0
    
    handle_player_takes!(game_state, turn, false)
  end
  
  def self.handle_player_takes!(game_state, turn, current_player)
    takes = find_takes(game_state, current_player)
    takes.each do |take|
      object_id = current_player ? game_state.current_player : GameConstants::WALL
      turn.deltas << Delta.new(take.x, take.y, object_id)
      game_state.board[take.x][take.y] = object_id
    end
    
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

    !counts.empty? && counts.each_value.max >= NUM_TO_TAKE
  end
  
  def self.player_is_up_down_right_or_left?(game_state, move)
    game_state.board[(move.x + 1) % game_state.board.size][move.y] == move.team ||
    game_state.board[(move.x - 1) % game_state.board.size][move.y] == move.team ||
    (game_state.board[move.x][(move.y + 1) % game_state.board.first.size] == move.team) ||
    (game_state.board[move.x][(move.y - 1) % game_state.board.first.size] == move.team)
  end
end
