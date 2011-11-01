import sys

BLANK = 0
WALL = 1
ME = int(sys.argv[1])

class IO(object):
  
  @staticmethod
  def read_game_state(gs_cls):
    """Return the game state object read from the standard input"""
    return gs_cls(IO.tokenize_input_string(sys.stdin.readline()))

  @staticmethod
  def send_move(x,y):
    """Send your move for turn"""
    print("%d,%d" % (x, y))
  
  @staticmethod
  def tokenize_input_string(string):
    array = map(lambda x: int(x), string.split(','))
    width = array.pop(0)
    height = array.pop(0)
    board = []
    for i in range(0, width):
      board.append([])
      for j in range(0, height):
        board[i].append(array.pop(0)) 
    return dict(width=width, height=height, board=board)


class GameState(object): 
  def __init__(self, data):
    self.width = data['width']
    self.height = data['height']
    self.board = data['board']
  
  @classmethod
  def get(cls):
    while True:
      yield IO.read_game_state(cls)

  @staticmethod
  def send_move(x, y):
    IO.send_move(x, y)
