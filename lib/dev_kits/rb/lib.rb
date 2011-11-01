$stdout.sync = true
module BlobWars
  class IO
    #returns GameState object
    def self.read_game_state
      GameState.new(tokenize_input_string(STDIN.readline))
    end
  
    def self.send_move(x,y)
      puts "#{x},#{y}"
    end
  
    private
    def tokenize_input_string(string)
      {:width => (width = (array = string.split(',').map! {|ele| ele.to_i}).shift), :height => (height = array.shift), :board => Array.new(width){|i| array.slice!(0,height)}}
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
end