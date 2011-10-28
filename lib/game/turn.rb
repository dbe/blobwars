class Turn
  
  def initialize(team)
    @team = team
    @deltas = []
  end
  
  attr_accessor :team, :deltas
  
end