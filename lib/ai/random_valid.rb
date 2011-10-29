require 'game/clients/player.rb'

require 'game/game_state.rb'
require 'game/move.rb'

class RandomValid < Player
  
  def initialize team
    super team
  end
  
  def get_move(game_state)
    possible_moves = get_all_possible_moves(game_state)
    new_move = possible_moves.empty? ? Move.new(-1, -1, @team) : possible_moves[rand(possible_moves.size)]
  end
  
end
