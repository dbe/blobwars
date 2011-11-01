class IO
  #returns GameState object
  def self.read_game_state
    GameState.new(tokenize_input_string(STDIN.readline))
  end
  
  def self.send_move(x,y)
    puts "#{x},#{y}"
    STDOUT.flush
  end
  
  private
  def tokenize_input_string(string)
    array = string.split(',').map! {|ele| ele.to_i}
    width = array.shift
    height = array.shift
    board = Array.new(width){|ele| array.slice!(0,height) }
    {:width => width, :height => height, :board => board}
  end
end

class GameState 
  attr_reader :width, :height, :board
  def initialize(hash)
    @width = hash.width
    @height = hash.height
    @board = hash.board
  end
  
  def self.get
    loop do
      IO.send_move(*(yield IO.read_game_state))
    end
  end
end


# def tokenize_input_string(s)
#   {:width => (width = (array = string.split(',')).shift.to_i), :height => (h = a.shift.to_i), :board => Array.new(g){|i| a.slice!(0,w).map! {|e| e.to_i}}}
# end


