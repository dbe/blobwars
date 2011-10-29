require 'spec_helper'

describe "ais/edit.html.haml" do
  before(:each) do
    @ai = assign(:ai, stub_model(Ai,
      :logic => "MyText",
      :player => nil,
      :name => "MyString"
    ))
  end

  it "renders the edit ai form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ais_path(@ai), :method => "post" do
      assert_select "textarea#ai_logic", :name => "ai[logic]"
      assert_select "input#ai_player", :name => "ai[player]"
      assert_select "input#ai_name", :name => "ai[name]"
    end
  end
end
