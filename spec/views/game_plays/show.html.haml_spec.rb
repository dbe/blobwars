require 'spec_helper'

describe "game_plays/show.html.haml" do
  before(:each) do
    @game_play = assign(:game_play, stub_model(GamePlay,
      :ai => nil,
      :game => nil,
      :winner => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
  end
end
