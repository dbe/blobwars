require 'lib/dev_kits/rb/lib'
require 'lib/dev_kits/rb/sample_toolkit'

class RandomBot < BlobWars::SampleBotBase
  
  def get_move(game_state)
    possible_moves = get_all_possible_moves(game_state)
    new_move = possible_moves[rand(possible_moves.size)]
  end
  
end

bot = RandomBot.new

BlobWars::GameState.get do |game_state|

  coord = bot.get_move(game_state) || BlobWars::Coordinate::INVALID

  [coord.x,coord.y]
end
