import lib

# Extend GameState class to add our own methods
class Coordinate(object):
  def __init__(self,x,y):
    self.x = x
    self.y = y

  def __add__(self,coord):
    return Coordinate(self.x + coord.x, self.y + coord.y)

  def __repr__(self):
    return "Coordinate(%d, %d)" % (self.x, self.y)

INVALID_COORDINATE = Coordinate(-1,-1)


class GameStateSample(lib.GameState):
    
  ALL_DIRECTIONS = [Coordinate(0,1), Coordinate(0,-1), Coordinate(1,0), Coordinate(-1,0)]
    
  def at(self,x,y):
    if x < 0 or x >= self.width: return None 
    if y < 0 or y >= self.height: return None 
    return self.board[x][y]

  def is_available(self,x,y):
    return self.at(x, y) == lib.BLANK

  def is_wall(self,x,y):
    return self.at(x, y) == lib.WALL

  def is_player(self,x,y):
    return self.at(x, y) and not self.is_wall(x, y) and not self.is_available(x, y)

  def is_same_player(self,x,y,team):
    return self.at(x, y) == team
    
  def is_valid(self,move):
    # Empty space condition
    if not self.is_available(move.x, move.y): return False
    # Adjacency condition
    return self.is_adjacent(move)

  def is_adjacent(self,move):
    for direction in GameStateSample.ALL_DIRECTIONS:
      adjacent_cell = move + direction
      if self.is_same_player(adjacent_cell.x, adjacent_cell.y, lib.ME): return True
    return False
  
class SampleBotBase(object):
  def get_move(self,game_state):
    """Implement this method in derived sample"""

  def get_possible_moves(self,game_state,position):
    """Provides the list of all moves from one position"""
    position_list = []
    for direction in GameStateSample.ALL_DIRECTIONS:
      move = position + direction
      if game_state.is_valid(move): position_list.append(move)
    return position_list

  def get_all_possible_moves(self,game_state):
    """Provides all the possible moves available for the player"""
    territory_list = self.get_territories(game_state, lib.ME)
    position_list = []
    for position in territory_list:
      position_list.extend(self.get_possible_moves(game_state, position))
    return position_list

  def get_territories(self,game_state,team):
    """Provides the list of all territories for the specified team"""
    territory_list = []
    for i in range(0, game_state.width):
      for j in range(0, game_state.height):
        if game_state.is_same_player(i, j, team): territory_list.append(Coordinate(i, j))
    return territory_list
 