require 'game/game_constants'
require 'game/game_state'
require 'game/game_initializer'
require 'game/game_utils'
# require 'game/move'
require 'game/turn'
require 'game/delta'


class GameRunner
  TURN_LIMIT = 500
  
  def play(players, height, width)
    @game_state = GameState.new(players, height, width)
    
    # Put players on board
    @initializer = GameInitializer.new
    @initializer.prepare(@game_state)
 
    while !@game_state.over do
      @game_state.players.each_index do |object_id|
        puts object_id
        
        # Set current player -- used elsewhere
        @game_state.current_player = players[object_id].team
        
        # Get player move
        move = players[object_id].get_move(@game_state)

        # Validate move
        if !GameUtils.valid?(@game_state, move)
          @game_state.player_passed
          next
        end
      
        # Apply move
        turn = @game_state.apply_move_and_return_turn(move, object_id)
  
        # Handle any takes
        GameUtils::handle_takes!(@game_state, turn)
        
        # Save turn
        @game_state.game_history << turn
      end
      
      # Rotate turn
      @game_state.rotate_turn!
    end
    
    winners = GameUtils::find_winners(@game_state)
    
    # puts "game state is #{@game_state.board[1]}"
    {:turns => @game_state.game_history, :dimensions => {:x => width, :y => height}, :winners => winners}
  end
  
end
