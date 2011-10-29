require 'spec_helper'

describe "ais/index.html.haml" do
  before(:each) do
    assign(:ais, [
      stub_model(Ai,
        :logic => "MyText",
        :player => nil,
        :name => "Name"
      ),
      stub_model(Ai,
        :logic => "MyText",
        :player => nil,
        :name => "Name"
      )
    ])
  end

  it "renders a list of ais" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
