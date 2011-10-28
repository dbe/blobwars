class GarethAi < Player
  def initialize(team)
    super(team)
  end
  
  def get_move(game_state)
    
  end
  
  private
  
  def score(board, player_id)
    get_players_tiles(board, player_id).size
  end
  
  def get_possible_moves(board, player_id)
    moves = []
    tiles = get_players_tiles(board, player_id)
  end
  
  def get_players_tiles(board, player_id)  
    board.each_index do |i|
      board.first.each_index do |j|
        tiles << {:x => i, :y => j} if board[i][j] == player_id
      end
    end
  end
  
end