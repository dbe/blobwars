require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe GamePlaysController do

  # This should return the minimal set of attributes required to create a valid
  # GamePlay. As you add validations to GamePlay, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all game_plays as @game_plays" do
      game_play = GamePlay.create! valid_attributes
      get :index
      assigns(:game_plays).should eq([game_play])
    end
  end

  describe "GET show" do
    it "assigns the requested game_play as @game_play" do
      game_play = GamePlay.create! valid_attributes
      get :show, :id => game_play.id
      assigns(:game_play).should eq(game_play)
    end
  end

  describe "GET new" do
    it "assigns a new game_play as @game_play" do
      get :new
      assigns(:game_play).should be_a_new(GamePlay)
    end
  end

  describe "GET edit" do
    it "assigns the requested game_play as @game_play" do
      game_play = GamePlay.create! valid_attributes
      get :edit, :id => game_play.id
      assigns(:game_play).should eq(game_play)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new GamePlay" do
        expect {
          post :create, :game_play => valid_attributes
        }.to change(GamePlay, :count).by(1)
      end

      it "assigns a newly created game_play as @game_play" do
        post :create, :game_play => valid_attributes
        assigns(:game_play).should be_a(GamePlay)
        assigns(:game_play).should be_persisted
      end

      it "redirects to the created game_play" do
        post :create, :game_play => valid_attributes
        response.should redirect_to(GamePlay.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved game_play as @game_play" do
        # Trigger the behavior that occurs when invalid params are submitted
        GamePlay.any_instance.stub(:save).and_return(false)
        post :create, :game_play => {}
        assigns(:game_play).should be_a_new(GamePlay)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        GamePlay.any_instance.stub(:save).and_return(false)
        post :create, :game_play => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested game_play" do
        game_play = GamePlay.create! valid_attributes
        # Assuming there are no other game_plays in the database, this
        # specifies that the GamePlay created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        GamePlay.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => game_play.id, :game_play => {'these' => 'params'}
      end

      it "assigns the requested game_play as @game_play" do
        game_play = GamePlay.create! valid_attributes
        put :update, :id => game_play.id, :game_play => valid_attributes
        assigns(:game_play).should eq(game_play)
      end

      it "redirects to the game_play" do
        game_play = GamePlay.create! valid_attributes
        put :update, :id => game_play.id, :game_play => valid_attributes
        response.should redirect_to(game_play)
      end
    end

    describe "with invalid params" do
      it "assigns the game_play as @game_play" do
        game_play = GamePlay.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        GamePlay.any_instance.stub(:save).and_return(false)
        put :update, :id => game_play.id, :game_play => {}
        assigns(:game_play).should eq(game_play)
      end

      it "re-renders the 'edit' template" do
        game_play = GamePlay.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        GamePlay.any_instance.stub(:save).and_return(false)
        put :update, :id => game_play.id, :game_play => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested game_play" do
      game_play = GamePlay.create! valid_attributes
      expect {
        delete :destroy, :id => game_play.id
      }.to change(GamePlay, :count).by(-1)
    end

    it "redirects to the game_plays list" do
      game_play = GamePlay.create! valid_attributes
      delete :destroy, :id => game_play.id
      response.should redirect_to(game_plays_url)
    end
  end

end
