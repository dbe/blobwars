require './lib/game/game_utils'
require './lib/game/move'

class Player
  
  ALL_DIRECTIONS = [Coordinate.new(0,1), Coordinate.new(0,-1), Coordinate.new(1,0), Coordinate.new(-1,0)]
  
  attr_reader :team
  
  def initialize number
    @team = number
  end
  
  def get_move(game_state)
    raise "Get move is abstract and must be overridden"
  end
  
  # Provides the list of all moves from one position
  def get_possible_moves(game_state, position)
    position_list = []
    ALL_DIRECTIONS.each do |direction|
      move = add_direction(position, direction)
      if GameUtils::valid?(game_state, move)
        position_list << move
      end
    end
    position_list
  end
  
  # Provides all the possible moves available for the player
  def get_all_possible_moves(game_state)
    territory_list = get_team_territories(game_state, @team)
    position_list = []
    territory_list.each do |position|
      position_list.concat(get_possible_moves(game_state, position))
    end
    position_list
  end
  
  # Provides the list of all territories for the specified team
  def get_team_territories(game_state, team)
    territory_list = []
    (0..game_state.board.width).each do |i| 
      (0..game_state.board.height).each do |j|
        if game_state.board.same_player?(i, j, team)
          territory_list << Move.new(i, j, team) 
        end
      end
    end
    territory_list
  end

  private
  
  def add_direction(move, direction)
    Move.new(move.x + direction.x, move.y + direction.y, move.team)
  end
  
end