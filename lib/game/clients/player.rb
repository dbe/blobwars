class Player
  attr_reader :team
  def initialize number
    @team = number
  end
  def get_move(game_state)
    raise "Get move is abstract and must be overridden"
  end
end