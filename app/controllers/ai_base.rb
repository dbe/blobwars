require 'game/game_state.rb'
class AiBase
  attr_reader :team
  
  def initialize team
    @team = team
  end
end