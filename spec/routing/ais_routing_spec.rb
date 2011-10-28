require "spec_helper"

describe AisController do
  describe "routing" do

    it "routes to #index" do
      get("/ais").should route_to("ais#index")
    end

    it "routes to #new" do
      get("/ais/new").should route_to("ais#new")
    end

    it "routes to #show" do
      get("/ais/1").should route_to("ais#show", :id => "1")
    end

    it "routes to #edit" do
      get("/ais/1/edit").should route_to("ais#edit", :id => "1")
    end

    it "routes to #create" do
      post("/ais").should route_to("ais#create")
    end

    it "routes to #update" do
      put("/ais/1").should route_to("ais#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/ais/1").should route_to("ais#destroy", :id => "1")
    end

  end
end
