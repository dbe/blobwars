require 'game/clients/player.rb'

require 'game/game_state.rb'
require 'game/move.rb'

class RandomValid < Player
  ALL_DIRECTIONS = [Coordinate.new(0,1), Coordinate.new(0,-1), Coordinate.new(1,0), Coordinate.new(-1,0)]
  
  def initialize team
    super team
    @last_move = nil
  end
  
  def get_move(game_state)
    directions = ALL_DIRECTIONS.dup
    
    # Search for starting point
    @last_move = starting_cell(game_state)

    # Init to be an invalid move
    new_move = Move.new(-1, -1, @team)
    while !directions.empty? && @last_move != nil
      direction = directions[rand(directions.size)]
      temp_move = add_direction(@last_move, direction)
      if GameUtils::valid?(game_state, temp_move)
        new_move = temp_move
        break
      else
        directions.delete(direction)
      end
    end
    
    if directions.empty? 
      @last_move = nil 
    else 
      @last_move = new_move
    end
    new_move
    
  end
  
  private
  
  def starting_cell(game_state)
    if @last_move == nil
      possible_starts = []
      width = game_state.board.width
      height = game_state.board.height
      (0..width).each do |i|
        (0..height).each do |j|
          if game_state.board.same_player?(i, j, @team)
            current_position = Move.new(i, j, @team)
            ALL_DIRECTIONS.each do |direction|
              move = add_direction(current_position, direction)
              if GameUtils::valid?(game_state, move)
                possible_starts << current_position
              end
            end
          end
        end  
      end
      @last_move = possible_starts[rand(possible_starts.size)]
    end
    @last_move
  end
  
  def add_direction(move, direction)
    Move.new(move.x + direction.x, move.y + direction.y, move.team)
  end
    
  
end
