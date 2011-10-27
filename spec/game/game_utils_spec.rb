require './spec/spec_helper'
require './lib/game/game_utils'

describe GameUtils do
  context "valid? is called with an invalid move" do
    it "should return false" do
    end
  end
  
  context "valid? is called with a valid move" do
    it "should return true" do
    end
  end
  
  context "handle_takes! is called" do
    it "should handle the takes for a turn appropriately" do
    end
  end
  
  context "handle_player_takes! is called" do
    it "should handle the takes for the current player appropriately" do
    end
  end
  
  context "find_takes is called for the current player" do
    it "should find all places where a non-current player is surrounded by 4+ of the current player" do
    end
  end
  
  context "find_takes is called for the non-current players" do
    it "should find all places where a player is surrounded by 4+ of any other one player" do
    end
  end
  
  context "surrounded? is called with a surrounded cell" do
    it "it should return true" do
    end
  end
  
  context "surrounded? is called with a non-surrounded cell" do
    it "it should return false" do
    end
  end
end
