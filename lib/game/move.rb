class Move
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
