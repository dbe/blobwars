class GameState
  def initialize(players, height, width)
    @players = players        # the client array
    @turn = 0                 # index into clients array
    @player_ate = false       # whether or not blob ate this turn
    
    @board = []
    height.times do
      row = []
      width.times do
        row << 0
      end
      
      @board << row
    end
  end
  
  def rotate_turn!
    @turn = (@turn + 1) % @num_players
  end
  
  def get_next_player
    @players[turn]
  end
  
  def player_ate?
    @player_ate
  end
end
