require './lib/game/game_state'
require './lib/game/game_board'

module GameUtils
  NUM_TO_TAKE = 4

  def self.find_winners(game_state)
    scores = Hash.new
    scores.default = 0
    # Count the number of tiles for each player
    (0..game_state.board.width).each do |i|
      (0..game_state.board.height).each do |j|
        scores[game_state.board.at(i,j)] += 1 if game_state.board.player?(i,j)
      end
    end
    
    max = scores.values.each.max
    scores.reject {|k,v| v != max}.keys
  end
  
  def self.valid?(game_state, move)
    # Empty space condition
    return false if !game_state.board.available?(move.x, move.y)
    
    # Adjacency condition
    adjacency?(game_state, move)
  end
  
  def self.adjacency?(game_state, move)
    game_state.board.same_player?(move.x + 1, move.y, move.team) ||
    game_state.board.same_player?(move.x - 1, move.y, move.team) ||
    game_state.board.same_player?(move.x, move.y + 1, move.team) ||
    game_state.board.same_player?(move.x, move.y - 1, move.team)
  end
  
  def self.handle_takes!(game_state, turn)
    # First we resolve all the current player takes
    begin
      takes = handle_player_takes!(game_state, turn, true)
    end while takes.size > 0
    
    # Then we create walls if other players can take back
    handle_player_takes!(game_state, turn, false)
  end
  
  def self.handle_player_takes!(game_state, turn, current_player)
    takes = find_takes(game_state, current_player)
    takes.each do |take|
      if current_player
        game_state.board.player!(take.x, take.y, game_state.current_player.team)
      else
        game_state.board.wall!(take.x, take.y)
      end
    end
    
    takes
  end
  
  def self.find_takes(game_state, current_player)
    # current_player: whether or not we're looking for
    # the takes of the player whose turn it is
    takes = []
    board = game_state.board
    (0..board.width).each do |i|
      (0..board.height).each do |j|
        if board.player?(i, j) 
          next if current_player && board.same_player?(i, j, game_state.current_player.team)
          takes << Coordinate.new(i, j) if surrounded?(game_state, i, j)
        end
      end
    end
    
    takes
  end
  
  def self.surrounded?(game_state, x, y)
    counts = {}
    counts.default = 0
    object_id = game_state.board.at(x, y)
    
    -1.upto(1) do |i|
      -1.upto(1) do |j|
        c_x = x + i
        c_y = y + j
        s_object_id = game_state.board.at(c_x, c_y)
        if game_state.board.player?(c_x, c_y) && object_id != s_object_id && s_object_id != nil
          counts[s_object_id] += 1
        end
      end  
    end

    !counts.empty? && counts.each_value.max >= NUM_TO_TAKE
  end

end
