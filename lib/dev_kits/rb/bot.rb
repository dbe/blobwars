require 'lib'

module BlobWars
  class GameState
    #Extend GameState here if you want
  end
end

BlobWars::GameState.get do |game_state|
  #Do logic, and set x and y variables of your intended move
  #Return -1,-1 to pass

  [x,y]
end
