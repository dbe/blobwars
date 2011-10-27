class SillyGameRunner
  class Delta
    attr_reader :x, :y, :team
    def initialize x,y,t
      @x = x
      @y = y
      @team = t
    end
  end
  def play *args
    squares = []
    200.times do |x|
      200.times do |y|
       squares << [x,y,rand(5) + 2]
      end
    end
    deltas = []
    300.times do
      deltas << Delta.new(*squares.sample.tap{|x| squares.delete x})
    end
    {:deltas => deltas,
      :winner => "danny"}
  end
end