require './lib/game/game_state'
require './lib/game/game_utils'
require './lib/game/move'

class GameInitializer
  def prepare(game_state)
    player_count = game_state.players.size
    width = game_state.board.size
    height = game_state.board.first.size
    return false if player_count > width * height
    game_state.players.each do |player|
      invalid_position = true
      begin
        x = rand(width)
        y = rand(height)
        coord = Coordinate.new(x, y)
        break if game_state.board[x][y] == GameConstants::BLANK
      end while true
      game_state.apply_move(x, y, player.team)
    end
  end
end