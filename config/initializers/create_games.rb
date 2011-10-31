LOGIC = <<-eof
  def initialize team
    super team
  end
  
  def get_move(game_state)
    possible_moves = get_all_possible_moves(game_state)
    new_move = possible_moves.empty? ? Move.new(-1, -1, @team) : possible_moves[rand(possible_moves.size)]
  end
            eof
            
SNAKE = <<-eof
def initialize team
  super team
  @current_position = nil
end

def get_move(game_state)
  if @current_position == nil || get_possible_moves(game_state, @current_position).empty?
    possible_moves = get_all_possible_moves(game_state)
    @current_position = possible_moves[rand(possible_moves.size)]
  else
    @current_position = get_possible_moves(game_state, @current_position)[0]
  end
  @current_position
end
eof
def run_games( sizes = [[20,20],[20,20],[20,20],[50,50]] )
  ais = []
  i = 0
  4.times do |j|
    
    current_logic = LOGIC
    if j % 2 == 0
      current_logic = SNAKE
    end
    ais << Player.create(:name => "Player #{i+=1}").ais.create(:logic => current_logic, :name => "ai_#{i}", :active => false)
  end
  sizes.each do |size|

    ais.each do |ai|
      Ai.find(ai.id).update_attribute(:active,true)
      puts "Is it active?"
      puts Ai.where(:active => true).count
    end
    puts "Playing game sized #{size.inspect}"
    Game.trigger *size
  end
end