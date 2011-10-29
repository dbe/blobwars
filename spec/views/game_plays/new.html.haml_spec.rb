require 'spec_helper'

describe "game_plays/new.html.haml" do
  before(:each) do
    assign(:game_play, stub_model(GamePlay,
      :ai => nil,
      :game => nil,
      :winner => false
    ).as_new_record)
  end

  it "renders new game_play form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => game_plays_path, :method => "post" do
      assert_select "input#game_play_ai", :name => "game_play[ai]"
      assert_select "input#game_play_game", :name => "game_play[game]"
      assert_select "input#game_play_winner", :name => "game_play[winner]"
    end
  end
end
