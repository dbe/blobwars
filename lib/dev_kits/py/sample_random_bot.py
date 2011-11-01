from sample_toolkit import SampleBotBase, GameStateSample, INVALID_COORDINATE
from random import randint

class RandomBot(SampleBotBase):
  def get_move(self,game_state):
    possible_moves = self.get_all_possible_moves(game_state)
    if possible_moves:
      return possible_moves[randint(0, len(possible_moves) - 1)]

bot = RandomBot()

for game_state in GameStateSample.get():
  coord = bot.get_move(game_state) or INVALID_COORDINATE
  game_state.send_move(coord.x, coord.y)
