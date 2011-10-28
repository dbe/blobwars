require './lib/game/game_state'
require './lib/game/game_utils'
require './lib/game/move'

class GameInitializer
  def prepare(game_state)
    player_count = game_state.players.size
    width = game_state.board.size
    height = game_state.board.first.size
    return false if player_count > width * height
    game_state.players.each_index do |object_id|
        team = game_state.players[object_id].team
      invalid_position = true
      begin
        x = rand(width)
        y = rand(height)
        coord = Coordinate.new(x, y)
        if game_state.board[x][y] == GameConstants::BLANK
          setup_move = Move.new(x, y, team)
          game_state.apply_move_and_return_turn(setup_move, object_id)
          break
        end
      end while true
    end
  end
end