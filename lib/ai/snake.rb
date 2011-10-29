require 'game/clients/player.rb'

require 'game/game_state.rb'
require 'game/move.rb'

class Snake < Player
  
  def initialize team
    super team
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
  
end
