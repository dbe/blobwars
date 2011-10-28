require 'spec_helper'

describe "games/index.html.haml" do
  before(:each) do
    assign(:games, [
      stub_model(Game,
        :move_history => "MyText",
        :game_runner_klass => "Game Runner Klass",
        :width => 1,
        :height => 1
      ),
      stub_model(Game,
        :move_history => "MyText",
        :game_runner_klass => "Game Runner Klass",
        :width => 1,
        :height => 1
      )
    ])
  end

  it "renders a list of games" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Game Runner Klass".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
