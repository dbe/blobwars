class Coordinate
  include Comparable
  
  def initialize(x, y)
    @x = x
    @y = y
  end
  
  def <=>(to_compare)
    diff = to_compare.x - @x
    return diff if diff
    return to_compare.y - @y
  end
  
  attr_accessor :x, :y
end

class Move
  def initialize(x, y, team)
    @coord = Coordinate.new(x, y)
    @team = team
  end
  
  def x
    @coord.x
  end
  
  def y
    @coord.y
  end
  
  attr_accessor :team
end
