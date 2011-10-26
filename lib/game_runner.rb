class GameRunner
  def self.play(players, height, width)
    game_state = GameState.new(players, height, width)
    
    while !game_over?(game) do
      # Decide whose turn it is
      game_state.rotate_turn! unless game_state.player_ate?
      player = game_state.get_next_player
      
      # Get client move
      move = player.get_move(game_state)
      
      # Execute client move
    end
  end
  
  private
  
  def game_over?(game)
    # TODO
    true
  end
  
end