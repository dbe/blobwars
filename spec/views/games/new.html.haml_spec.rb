require 'spec_helper'

describe "games/new.html.haml" do
  before(:each) do
    assign(:game, stub_model(Game,
      :move_history => "MyText",
      :game_runner_klass => "MyString",
      :width => 1,
      :height => 1
    ).as_new_record)
  end

  it "renders new game form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => games_path, :method => "post" do
      assert_select "textarea#game_move_history", :name => "game[move_history]"
      assert_select "input#game_game_runner_klass", :name => "game[game_runner_klass]"
      assert_select "input#game_width", :name => "game[width]"
      assert_select "input#game_height", :name => "game[height]"
    end
  end
end
