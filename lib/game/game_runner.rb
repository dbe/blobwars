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
      @game_state.players.each do |player|
        
        turn = Turn.new(player.team)
        @game_state.board.deltas = []
        @game_state.current_player = player
      
        # Get player move
        move = player.get_move(@game_state)

        # Validate move
        if GameUtils.valid?(@game_state, move)
          # Apply move
          @game_state.board.player!(move.x, move.y, move.team)

          # Handle any takes
          GameUtils::handle_takes!(@game_state, turn)
        elseß
          @game_state.player_passed
        end
      
        # Save and Reset deltas
        turn.deltas = @game_state.board.deltas
          
        # Save turn
        @game_state.game_history << turn
      end
      
      # Rotate turn
      @game_state.rotate_turn!
    end
    
    winners = GameUtils::find_winners(@game_state)
    #puts "#{@game_state.game_history.inspect}"
    # puts "game state is #{@game_state.board[1]}"
    {:turns => @game_state.game_history, :dimensions => {:x => width, :y => height}, :winners => winners}
  end
  
end
