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
    puts "Passed count : #{@passed_count}"
    puts "Turn : #{@turn}"
    @over = true if @turn > TURN_LIMIT || @passed_count == players.size
    passed_count = 0
  end

  def player_passed
    @passed_count += 1
  end
  
  def apply_move(x, y, tile_id)
    @board[x][y] = tile_id
    @game_history << Move.new(x, y, tile_id)
  end
  
end
