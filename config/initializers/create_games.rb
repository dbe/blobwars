LOGIC = <<-eof
  def initialize team
    super team
  end
  
  def get_move(game_state)
    possible_moves = get_all_possible_moves(game_state)
    new_move = possible_moves.empty? ? Move.new(-1, -1, @team) : possible_moves[rand(possible_moves.size)]
  end
            eof
            
def run_games( sizes = [[20,20],[20,20],[20,20],[50,50],[50,50],[100,100],[200,200]] )
  ais = []
  i = 0
  4.times do
    ais << Player.create(:name => "Player #{i+=1}").ais.create(:logic => LOGIC, :name => "ai_#{i}", :active => false)
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