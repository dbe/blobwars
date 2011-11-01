from sample_toolkit import SampleBotBase, GameStateSample, INVALID_COORDINATE
from random import randint

class SnakeBot(SampleBotBase):
  def __init__(self):
    self._current_position = None

  def get_move(self,game_state):
    if not self._current_position or not self.get_possible_moves(game_state, self._current_position):
      possible_moves = self.get_all_possible_moves(game_state)
      if possible_moves:
        self._current_position = possible_moves[randint(0, len(possible_moves))]
    else:
      self._current_position = self.get_possible_moves(game_state, self._current_position)[0]
    return self._current_position

bot = SnakeBot()

for game_state in GameStateSample.get():
  coord = bot.get_move(game_state) or INVALID_COORDINATE
  game_state.send_move(coord.x, coord.y)
