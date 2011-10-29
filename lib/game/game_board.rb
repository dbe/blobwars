require './lib/game/delta'

class Board
  BLANK = 0
  WALL = 1
  
  def initialize(height,width,team_2_object_id)
    @height = height
    @width = width
    @team_2_object_id = team_2_object_id
    @deltas = []
    
    @board = []
    width.times do
      col = [ BLANK ] * height
      @board << col
    end
  end
  
  attr_reader :height, :width
  attr_accessor :deltas
  
  def at(x,y)
    # Make sure we are in border
    return nil if x < 0 || x >= @width
    return nil if y < 0 || y >= @height
    
    @board[x][y]
  end
  
  # Cells status operations
  def available?(x,y)
    at(x, y) == BLANK
  end
  
  def wall?(x,y)
    at(x, y) == WALL
  end

  def player?(x,y)
    @team_2_object_id.has_value?(at(x, y))
  end
  
  def same_player?(x,y,team)
    at(x, y) == @team_2_object_id[team]
  end
  
  def wall!(x,y)
     set(x, y, WALL)
  end
  
  def player!(x,y,team)
     set(x, y, @team_2_object_id[team])
  end
  
  private
  
  def set(x,y,object_id)
    if at(x, y) != nil
      @board[x][y] = object_id
      @deltas << Delta.new(x, y, object_id)
    end
  end
  
end