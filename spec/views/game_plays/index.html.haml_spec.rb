require 'spec_helper'

describe "game_plays/index.html.haml" do
  before(:each) do
    assign(:game_plays, [
      stub_model(GamePlay,
        :ai => nil,
        :game => nil,
        :winner => false
      ),
      stub_model(GamePlay,
        :ai => nil,
        :game => nil,
        :winner => false
      )
    ])
  end

  it "renders a list of game_plays" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
