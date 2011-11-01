require 'lib'
require 'sample_toolkit'

class SnakeBot < BlobWars::SampleBotBase
  def initialize
    super
    @current_position = nil
  end
  
  def get_move(game_state)
    if @current_position == nil || get_possible_moves(game_state, @current_position).empty?
      possible_moves = get_all_possible_moves(game_state)
      puts possible_moves.inspect
      @current_position = possible_moves[rand(possible_moves.size)]
    else
      @current_position = get_possible_moves(game_state, @current_position)[0]
    end
    @current_position
  end
end

bot = SnakeBot.new

BlobWars::GameState.get do |game_state|
  coord = bot.get_move(game_state) || BlobWars::Coordinate::INVALID
  
  [coord.x,coord.y]
end
