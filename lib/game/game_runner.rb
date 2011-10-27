require 'game/game_constants'
require 'game/game_state'
require 'game/game_utils'
require 'game/move'


class GameRunner
  TURN_LIMIT = 500
  
  def play(players, height, width)
    @game_state = GameState.new(players, height, width)
    
    # Put players on board
    # TODO
    
    while !@game_state.over do
      # Get the player whose turn it is
      player = @game_state.get_next_player
      
      # Get client move
      move = player.get_move(@game_state)
      
      # Validate move
      next if !GameUtils.valid?(@game_state, move)
      
      # Apply move
      @game_state.apply_move(move.x, move.y, player.team)
      
      # Handle any takes
      GameUtils::handle_takes!(@game_state)
      
      # Rotate turn
      @game_state.rotate_turn!
    end
    
    puts "game state is #{@game_state}"
    {:deltas => @game_state.game_history, :winner => 'danny'}
  end
  
end
