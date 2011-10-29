require 'spec_helper'

describe "games/show.html.haml" do
  before(:each) do
    @game = assign(:game, stub_model(Game,
      :move_history => "MyText",
      :game_runner_klass => "Game Runner Klass",
      :width => 1,
      :height => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Game Runner Klass/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
