require 'game/clients/player.rb'
class HumanPlayer < Player
  def get_move(game_state)
    Move.new(rand(200),rand(200), team)
  end
end
