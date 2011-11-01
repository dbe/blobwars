require 'lib'
require 'sample_toolkit'

bot = RandomBot.new

BlobWars::GameState.get do |game_state|
  coord = bot.get_move(game_state)
  
  [coord.x,coord.y]
end

class RandomBot < SampleBotBase
  
  def get_move(game_state)
    possible_moves = get_all_possible_moves(game_state)
    new_move = possible_moves.empty? ? Move.new(-1, -1) : possible_moves[rand(possible_moves.size)]
  end
  
end
