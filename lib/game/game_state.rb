require './lib/game/game_constants'

class GameState
  TURN_LIMIT = 500

  def initialize(players, height, width)
    @players = players        # the client array
    @turn = 0                 # index into clients array
    @current_player = @players[@turn]
    @over = false
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
    puts "We're at turn #{@turn}"
    @turn += 1
    @current_player = @players[@turn % @players.size].team
    @over = true if @turn > TURN_LIMIT
  end
  
  def get_next_player
    @players[@turn % @players.size]
  end
  
  def apply_move(x, y, player)
    @board[x][y] = player
    @game_history << Move.new(x, y, player)
  end
  
  def player_ate?
    @player_ate
  end
end
