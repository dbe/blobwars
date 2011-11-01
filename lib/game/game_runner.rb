require 'game/game_state'
require 'game/game_initializer'
require 'game/game_utils'
require 'game/turn'
require 'game/delta'

class GameRunner  
  def play(players, height, width)
    @game_state = GameState.new(players, height, width)
    
    # Put players on board
    @initializer = GameInitializer.new
    @initializer.prepare(@game_state)
 
    while !@game_state.over do
      @game_state.players.each do |player|
        # Player takes a turn
        turn = Turn.new(player.team)
        @game_state.board.deltas = []         # Does the board need to own the deltas? Can we keep this with turn?
      
        # Get player move
        move = player.get_move(@game_state)

        # Validate move
        if move != nil && GameUtils.valid?(@game_state, move)
          # Apply move
          @game_state.board.player!(move.x, move.y, move.team)    # Maybe rename this? What does player! mean here?

          # Handle any takes
          GameUtils::handle_takes!(@game_state, turn)
        else
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
    
    {:turns => @game_state.game_history.map {|turn| {:playerID => turn.team, :deltas => turn.deltas.map {|delta| {:x => delta.x, :y => delta.y, :objectID => delta.object_id}}}}, 
    :dimensions => {:x => width, :y => height}, 
    :winners => GameUtils::find_winners(@game_state)}
  end
  
end
