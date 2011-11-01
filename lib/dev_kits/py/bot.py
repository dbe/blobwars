from lib import GameState

for game_state in GameState.get():
  #Do logic, and set x and y variables of your intended move
  #Return -1,-1 to pass
  x, y = -1, -1
  game_state.send_move(x, y)

