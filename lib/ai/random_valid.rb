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
    (0..game_state.board.width).each do |i|
      (0..game_state.board.height).each do |j|
        if game_state.board.same_player?(i, j, @team)
          current_position = Move.new(i, j, @team)
          ALL_DIRECTIONS.each do |direction|
            move = add_direction(current_position, direction)
            if GameUtils::valid?(game_state, move)
              return move
            end
          end
        end
      end  
    end
    Move.new(-1, -1, @team)
  end
  
  def add_direction(move, direction)
    Move.new(move.x + direction.x, move.y + direction.y, move.team)
  end
    
  
end
