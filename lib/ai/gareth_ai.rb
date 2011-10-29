class GarethAi < Player
  LEVELS = 5
  
  def initialize(team)
    super(team)
  end
  
  def get_move(game_state)
    best_score = Integer::MIN
    best_move = nil
    
    get_possible_moves(game_state).each do |move|
      tree = build_game_tree(game_state_after_move(game_state, move), LEVELS)
      score = minimax(tree).score
      if score > best_score
        best_score = score
        best_move = move
      end
    end
    
    best_move
  end
  
  private
  
  # Build game tree
  def build_game_tree(game_state, level)
    if levels == 0
      [game_state]
    else
      game_tree = [game_state]
      get_possible_moves(game_state.board, game_state.object_id).each do |move|
        game_tree << build_game_tree(game_state_after_move(game_state, move), level - 1)
      end
      
      game_tree
    end
  end
  
  def minimax(tree)
    # Pull out the root
    root = tree.shift
    
    if tree.first.size == 1
      best_score = Integer::MIN
      best_state = nil
      
      tree.map(&:first).each do |child|
        child_score = score(child, root.current_player)
        if child_score > best_score
          child_score = best_score
          best_state = child
        end
        
        GameStateAndScore.new(root, best_score)
    else
      children = tree.map {|child| minimax(child)}
      worst_score = Integer::MAX
      worst_state = nil
      
      children.each do |child|
        if child.score < worst_score
          worst_score = child.score
          worst_state = child.state
        end
        
        GameStateAndScore.new(root, score(worst_before, root.current_player))
      end
    end
  end
  
  def score(board, current_player)
    get_players_tiles(board, current_player).size
  end
  
  def get_players_tiles(board, current_player)
    # TODO
  end
  
  private
  
  class BeforeAfterAndScore
    def initialize(before, after, score)
      @before = before
      @after = after
      @score = score
    end
    
    attr_accessor :before, :after, :score
  end
  
  class GameStateAndScore
    def initialize(game_state, score)
      @game_state = game_state
      @score = score
    end
    
    attr_accessor :game_state, :score
  end
  
  def get_possible_moves(game_state)
    # TODO
  end
  
  def game_state_after_move(game_state, move)
    # TODO
  end
  
  
end