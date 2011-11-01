require 'lib'

module BlobWars
  class GameState
    
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
      !wall?(x, y) && !available?(x, y)
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
      same_player?(move.x + 1, move.y, ME) ||
      same_player?(move.x - 1, move.y, ME) ||
      same_player?(move.x, move.y + 1, ME) ||
      same_player?(move.x, move.y - 1, ME)
    end
  end
end

bot = SnakeBot.new


BlobWars::GameState.get do |game_state|
  #Do logic, and set x and y variables of your intended move
  
  coord = bot.get_move(game_state)
  
  [coord.x,coord.y]
end


class Coordinate
  def initialize(x, y)
    @x = x
    @y = y
  end

  attr_accessor :x, :y
end

class SnakeBot
  ALL_DIRECTIONS = [Coordinate.new(0,1), Coordinate.new(0,-1), Coordinate.new(1,0), Coordinate.new(-1,0)]
  
  attr_reader :team
  
  def initialize
    @team = ME
    @current_position = nil
  end
  
  def get_move(game_state)
    if @current_position == nil || get_possible_moves(game_state, @current_position).empty?
      possible_moves = get_all_possible_moves(game_state)
      @current_position = possible_moves[rand(possible_moves.size)]
    else
      @current_position = get_possible_moves(game_state, @current_position)[0]
    end
    @current_position
  end

  # Provides the list of all moves from one position
  def get_possible_moves(game_state, position)
    position_list = []
    ALL_DIRECTIONS.each do |direction|
      move = add_direction(position, direction)
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
    (0..game_state.width).each do |i| 
      (0..game_state.height).each do |j|
        if game_state.same_player?(i, j)
          territory_list << Coordinate.new(i, j) 
        end
      end
    end
    territory_list
  end

  private
  
  def add_direction(move, direction)
    Coordinate.new(move.x + direction.x, move.y + direction.y)
  end
end