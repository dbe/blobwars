require './lib/game/game_constants'

class GameState
  def initialize(players, height, width)
    @players = players        # the client array
    @turn = 0                 # index into clients array
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
  
  attr_accessor :board, :turn, :over, :players, :game_history
  
  def rotate_turn!
    @turn = (@turn + 1) % @players.size
  end
  
  def get_next_player
    @players[turn]
  end
  
  def apply_move(x, y, player)
    @board[x][y] = player
    @game_history << Move.new(x, y, player)
  end
  
  def player_ate?
    @player_ate
  end
end
