require 'game/game_constants'
require 'game/game_state'
require 'game/game_initializer'
require 'game/game_utils'
require 'game/move'


class GameRunner
  TURN_LIMIT = 500
  
  def play(players, height, width)
    puts players
    @game_state = GameState.new(players, height, width)
    
    # Put players on board
    @initializer = GameInitializer.new
    @initializer.prepare(@game_state)
 
    while !@game_state.over do
      @game_state.players.each do |player|
        # Get current player
        # @game_state.current_player = player.player_id
        @game_state.current_player = player.team
        
        # Get player move
        move = player.get_move(@game_state)

        # Validate move
        if !GameUtils.valid?(@game_state, move)
          @game_state.player_passed
          next
        end
      
        # Apply move
        @game_state.apply_move(move.x, move.y, player.team)
  
        # Handle any takes
        GameUtils::handle_takes!(@game_state)
      
      end
      
      # Rotate turn
      @game_state.rotate_turn!
    end
    
    puts "game state is #{@game_state.board[1]}"
    {:deltas => @game_state.game_history, :winner => 'danny'}
  end
  
end
