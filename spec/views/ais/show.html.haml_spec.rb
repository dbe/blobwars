require 'spec_helper'

describe "ais/show.html.haml" do
  before(:each) do
    @ai = assign(:ai, stub_model(Ai,
      :logic => "MyText",
      :player => nil,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
