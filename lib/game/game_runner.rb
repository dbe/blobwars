require 'game/game_constants'
require 'game/game_state'
require 'game/game_utils'
require 'game/move'


class GameRunner
  TURN_LIMIT = 500
  
  def play(players, height, width)
    @game_state = GameState.new(players, height, width)
    @game_history = []
    
    # Put players on board
    # TODO
    
    current_turn = 0
    
    while !@game_state.over do
      break if (current_turn+=1) == 500
      # Get the player whose turn it is
      player = @game_state.get_next_player
      
      begin
        # Player has not yet eaten
        food = false
        
        # Get client move
        move = player.get_move(@game_state)
        
        @game_history << Move.new(move.x, move.y, player.team)
      
        # Validate move
        #TODO - will this break out of the while loop, or the begin/end loop
        break if !GameUtils.valid?(@game_state, move)
      
        # Execute move
        food = true if @game_state.board[move.x][move.y] == GameConstants::FOOD
        @game_state.board[move.x][move.y] = @game_state.turn   # players ids on board are position in client array
      
        # Handle any takes
        GameUtils::handle_takes!(@game_state)
      end while food
      
      # Rotate turn
      @game_state.rotate_turn!
    end
    puts "game state is #{@game_state}"
    {:deltas => @game_history, :winner => 'danny'}
  end
  
end
