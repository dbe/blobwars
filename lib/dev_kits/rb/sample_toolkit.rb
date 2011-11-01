require 'lib'

# Extend GameState class to add our own methods
module BlobWars
  class GameState
    
    ALL_DIRECTIONS = [Coordinate.new(0,1), Coordinate.new(0,-1), Coordinate.new(1,0), Coordinate.new(-1,0)]
    
    def at(x,y)
      # Make sure we are in border
      return nil if x < 0 || x >= @width
      return nil if y < 0 || y >= @height

      @board[x][y]
    end

    # Cells status
    def available?(x,y)
      at(x, y) == BLANK
    end

    def wall?(x,y)
      at(x, y) == WALL
    end

    def player?(x,y)
      at(x, y) != nil && !wall?(x, y) && !available?(x, y)
    end

    def same_player?(x,y,team)
      at(x, y) == team
    end
    
    def valid?(move)
      # Empty space condition
      return false if !available?(move.x, move.y)

      # Adjacency condition
      adjacency?(game_state, move)
    end

    def adjacency?(move)
      ALL_DIRECTIONS.each do |direction|
        adjacent_cell = move + direction
        true if same_player?(adjacent_cell.x, adjacent_cell.y, ME)
      end
      false
    end
  end
end

class Coordinate
  def initialize(x, y)
    @x = x
    @y = y
  end
  
  def +(coord)
    return Coordinate.new(x + coord.x, y + coord.y)
  end

  attr_accessor :x, :y
end

class SampleBotBase
  
  def get_move(game_state)
    # Implement this method in derived sample
  end

  # Provides the list of all moves from one position
  def get_possible_moves(game_state, position)
    position_list = []
    game_state.ALL_DIRECTIONS.each do |direction|
      move = position + direction
      if game_state.valid?(move)
        position_list << move
      end
    end
    position_list
  end

  # Provides all the possible moves available for the player
  def get_all_possible_moves(game_state)
    territory_list = get_territories(game_state)
    position_list = []
    territory_list.each do |position|
      position_list.concat(get_possible_moves(game_state, position))
    end
    position_list
  end

  # Provides the list of all territories for the specified team
  def get_territories(game_state)
    territory_list = []
    (0...game_state.width).each do |i| 
      (0...game_state.height).each do |j|
        if game_state.same_player?(i, j)
          territory_list << Coordinate.new(i, j) 
        end
      end
    end
    territory_list
  end

end
