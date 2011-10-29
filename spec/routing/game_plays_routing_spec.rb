require "spec_helper"

describe GamePlaysController do
  describe "routing" do

    it "routes to #index" do
      get("/game_plays").should route_to("game_plays#index")
    end

    it "routes to #new" do
      get("/game_plays/new").should route_to("game_plays#new")
    end

    it "routes to #show" do
      get("/game_plays/1").should route_to("game_plays#show", :id => "1")
    end

    it "routes to #edit" do
      get("/game_plays/1/edit").should route_to("game_plays#edit", :id => "1")
    end

    it "routes to #create" do
      post("/game_plays").should route_to("game_plays#create")
    end

    it "routes to #update" do
      put("/game_plays/1").should route_to("game_plays#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/game_plays/1").should route_to("game_plays#destroy", :id => "1")
    end

  end
end
