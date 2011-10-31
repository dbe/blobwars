require './lib/game/game_board'

class GameState
  TURN_LIMIT = 2000

  def initialize(players, height, width)
    @players = players        # the client array
    @turn = 0                 # turn id
    @over = false
    @passed_count = 0
    
    @team_2_object_id = {}
    players.each_with_index do |player,index|
      object_id = index + 2
      @team_2_object_id[player.team] = object_id
    end
    
    @game_history = []
    
    @board = Board.new(height, width, @team_2_object_id)
  end
  
  attr_accessor :board, :over, :players, :game_history, :current_player

  
  def rotate_turn!
    @turn += 1
    puts "Turn limit reached" if @turn > TURN_LIMIT
    puts "All players passed" if @passed_count == players.size
    @over = true if @turn > TURN_LIMIT || @passed_count == players.size
    @passed_count = 0
  end

  def player_passed
    @passed_count += 1
  end

end
