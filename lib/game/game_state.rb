require './lib/game/game_constants'

class GameState
  def initialize(players, height, width)
    @players = players        # the client array
    @turn = 0                 # index into clients array
    @over = false
    
    @board = []
    width.times do
      col = []
      height.times do
        col << GameConstants::BLANK
      end
      
      @board << col
    end
  end
  
  attr_accessor :board, :turn, :over, :players
  
  def rotate_turn!
    @turn += 1
    @over = true if @turn == TURN_LIMIT
  end
  
  def get_next_player
    @players[turn % @players.size]
  end
  
  def player_ate?
    @player_ate
  end
end
