class GameHistoriesController < ApplicationController
  # GET /game_histories
  # GET /game_histories.xml
  def index
    @game_histories = GameHistory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @game_histories }
    end
  end

  # GET /game_histories/1
  # GET /game_histories/1.xml
  def show
    #@game_history = GameHistory.find(params[:id])
    #json = @game_history.move_history
    @json = GameHistory.find(params[:id]).jsonify

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @game_history }
    end
  end

  # GET /game_histories/new
  # GET /game_histories/new.xml
  # def new
  #     @game_history = GameHistory.new
  # 
  #     respond_to do |format|
  #       format.html # new.html.erb
  #       format.xml  { render :xml => @game_history }
  #     end
  #   end

  # GET /game_histories/1/edit
  # def edit
  #     @game_history = GameHistory.find(params[:id])
  #   end

  # POST /game_histories
  # POST /game_histories.xml
  # def create
  #     #TODO - when we run this, we'll need to actually run the game, and create the game_history based on the result of that.
  #     @game_history = GameHistory.new(params[:game_history])
  # 
  #     respond_to do |format|
  #       if @game_history.save
  #         format.html { redirect_to(@game_history, :notice => 'Game history was successfully created.') }
  #         format.xml  { render :xml => @game_history, :status => :created, :location => @game_history }
  #       else
  #         format.html { render :action => "new" }
  #         format.xml  { render :xml => @game_history.errors, :status => :unprocessable_entity }
  #       end
  #     end
  #   end

  # PUT /game_histories/1
  # PUT /game_histories/1.xml
  # def update
  #     @game_history = GameHistory.find(params[:id])
  # 
  #     respond_to do |format|
  #       if @game_history.update_attributes(params[:game_history])
  #         format.html { redirect_to(@game_history, :notice => 'Game history was successfully updated.') }
  #         format.xml  { head :ok }
  #       else
  #         format.html { render :action => "edit" }
  #         format.xml  { render :xml => @game_history.errors, :status => :unprocessable_entity }
  #       end
  #     end
  #   end

  # DELETE /game_histories/1
  # DELETE /game_histories/1.xml
  # def destroy
  #     @game_history = GameHistory.find(params[:id])
  #     @game_history.destroy
  # 
  #     respond_to do |format|
  #       format.html { redirect_to(game_histories_url) }
  #       format.xml  { head :ok }
  #     end
  #   end
end
