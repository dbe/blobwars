require './lib/game/game_constants'

class GameState
  TURN_LIMIT = 500

  def initialize(players, height, width)
    @players = players        # the client array
    @turn = 0                 # turn id
    @over = false
    @passed_count = 0
    @game_history = []
    
    @board = []
    width.times do
      col = []
      height.times do
        col << GameConstants::BLANK
      end
      
      @board << col
    end
  end
  
  attr_accessor :board, :over, :players, :game_history, :current_player
  
  def rotate_turn!
    @turn += 1
    @over = true if @turn > TURN_LIMIT || @passed_count == players.size
    passed_count = 0
  end

  def player_passed
    @passed_count += 1
  end
  
  def apply_move_and_return_turn(move, object_id)
    @board[move.x][move.y] = move.team
    turn = Turn.new(move.team)
    turn.deltas << Delta.new(move.x, move.y, object_id)
    turn
  end
end
