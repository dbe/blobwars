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
    
    while !@game_state.over do
      # Get the player whose turn it is
      player = @game_state.get_next_player
      
      # Get client move
      move = player.get_move(@game_state)
      
      # Add the move to the game history
      @game_history << Move.new(move.x, move.y, player.team)
      
      # Validate move
      next if !GameUtils.valid?(@game_state, move)
      
      # Execute move
      @game_state.board[move.x][move.y] = @game_state.turn   # players ids on board are position in client array
      
      # Handle any takes
      GameUtils::handle_takes!(@game_state)
      
      # Rotate turn
      @game_state.rotate_turn!
    end
    
    puts "game state is #{@game_state}"
    {:deltas => @game_history, :winner => 'danny'}
  end
  
end
