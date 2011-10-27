class GameState
  def initialize(players, height, width)
    @players = players        # the client array
    @turn = 0                 # index into clients array
    @over = false
    
    @board = []
    height.times do
      row = []
      width.times do
        row << GameConstants::BLANK
      end
      
      @board << row
    end
  end
  
  attr_accessor :board, :turn, :over
  
  def rotate_turn!
    @turn = (@turn + 1) % @players.size
  end
  
  def get_next_player
    @players[turn]
  end
  
  def player_ate?
    @player_ate
  end
end
