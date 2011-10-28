require 'game/clients/player.rb'

require 'game/game_state.rb'
require 'game/move.rb'

class RandomValid < Player
  def initialize team
    super team
    @last_move = nil
  end
  
  def get_move(game_state)
    # Search for starting point
    if @last_move == nil
      game_state.board.each_index do |i|
        game_state.board[i].each_index do |j|
          if game_state.board[i][j] == @team
            puts "found myself at #{i}, #{j}"
            @last_move = Move.new(i, j, @team)
          end
        end  
      end
    end

    # Init to be an invalid move
    directions = [Coordinate.new(0,1), Coordinate.new(0,-1), Coordinate.new(1,0), Coordinate.new(-1,0)]
    new_move = Move.new(-1, -1, @team)
    while !directions.empty?
      direction = directions[rand(directions.size)]
      temp_move = Move.new(@last_move.x + direction.x, @last_move.y + direction.y, @team)
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
end
