require './spec/spec_helper'
require './lib/game/game_utils'
require './lib/game/game_state'
require './lib/game/move'

describe GameUtils do
  before(:each) do
    @game_state = GameState.new(2, 5, 5)
    @game_state.board[0][0] = 0
    @game_state.board[4][4] = 1
    
    @game_state2 = GameState.new(2, 5, 5)
    @game_state2.board[2][2] = 0
    @game_state2.board[2][3] = 1
    @game_state2.board[2][1] = 1
    @game_state2.board[1][2] = 1
    @game_state2.board[3][2] = 1
    
    @game_state3 = GameState.new(2, 5, 5)
    @game_state3.board[0][0] = 0
    @game_state3.board[0][1] = 1
    @game_state3.board[1][0] = 1
    @game_state3.board[1][1] = 1
  end
  
  context "valid? is called with an invalid move" do
    it "should return false" do
      GameUtils::valid?(@game_state, Move.new(0,0)).should == false
    end
    it "should return false" do
      GameUtils::valid?(@game_state, Move.new(2,2)).should == false
    end
    it "should return false" do
      GameUtils::valid?(@game_state, Move.new(4,3)).should == false
    end
    it "should return false" do
      GameUtils::valid?(@game_state, Move.new(1,1)).should == false
    end
  end
  
  context "valid? is called with a valid move" do
    it "should return true" do
      GameUtils::valid?(@game_state, Move.new(0,1)).should == true
    end
    it "should return true" do
      GameUtils::valid?(@game_state, Move.new(1,0)).should == true
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
      GameUtils::surrounded?(@game_state2, 2, 2).should == true
    end
  end

  context "surrounded? is called with a surrounded cell" do
    it "it should return true" do
      GameUtils::surrounded?(@game_state3, 0, 0).should == true
    end
  end

  
  context "surrounded? is called with a non-surrounded cell" do
    it "it should return false" do
    end
  end
end
