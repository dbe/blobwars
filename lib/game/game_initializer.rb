require './lib/game/game_state'
require './lib/game/game_utils'
require './lib/game/move'

class GameInitializer
  def prepare(game_state)
    player_count = game_state.players.size
    width = game_state.board.width
    height = game_state.board.height
    
    return false if player_count > width * height
    
    game_state.players.each do |player|
      invalid_position = true
      begin
        x = rand(width)
        y = rand(height)
        if game_state.board.available?(x,y)
          turn = Turn.new(player.team)
          game_state.board.deltas = []
          game_state.board.player!(x,y,player.team)
          turn.deltas = game_state.board.deltas
          game_state.game_history << turn
          break
        end
      end while true
    end
  end
end