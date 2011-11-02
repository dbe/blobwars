require './lib/game/game_state'
require './lib/game/game_board'

module GameUtils
  NUM_TO_TAKE = 4

  def self.find_winners(game_state)
    scores = Hash.new
    scores.default = 0
    # Count the number of tiles for each player
    (0...game_state.board.width).each do |i|
      (0...game_state.board.height).each do |j|
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
  
  def self.handle_takes!(game_state, move, turn)
    # First we resolve all the current player takes
    move_list = Set.new [move]
    all_moves = Set.new []
    
    begin
      all_moves += move_list
      move_list = handle_player_takes!(game_state, move_list, turn)
    end while !move_list.empty?
    
    # Then we create walls if other players can take back
    all_moves.each do |take|
      game_state.board.wall!(take.x, take.y) if surrounded?(game_state, take.x, take.y)
    end
  end
  
  def self.handle_player_takes!(game_state, move_list, turn)
    takes = find_takes(game_state, move_list)
    takes.each do |take|
      game_state.board.player!(take.x, take.y, game_state.current_player.team)
    end
    takes
  end
  
  def self.find_takes(game_state, move_list)
    takes = []
    board = game_state.board
    move_list.each do |move|
      -1.upto(1) do |i|
        -1.upto(1) do |j|
          c_x, c_y = move.x + i, move.y + j
          if board.player?(c_x, c_y) && !board.same_player?(c_x, c_y, game_state.current_player.team)
            takes << Coordinate.new(c_x, c_y) if surrounded?(game_state, c_x, c_y)
          end
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
        c_x, c_y = x + i, y + j
        s_object_id = game_state.board.at(c_x, c_y)
        if game_state.board.player?(c_x, c_y) && object_id != s_object_id && s_object_id != nil
          counts[s_object_id] += 1
        end
      end  
    end

    !counts.empty? && counts.each_value.max >= NUM_TO_TAKE
  end

end
