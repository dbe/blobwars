class GamePlaysController < ApplicationController
  # GET /game_plays
  # GET /game_plays.xml
  def index
    @game_plays = GamePlay.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @game_plays }
    end
  end

  # GET /game_plays/1
  # GET /game_plays/1.xml
  def show
    @game_play = GamePlay.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @game_play }
    end
  end

  # GET /game_plays/new
  # GET /game_plays/new.xml
  def new
    @game_play = GamePlay.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @game_play }
    end
  end

  # GET /game_plays/1/edit
  def edit
    @game_play = GamePlay.find(params[:id])
  end

  # POST /game_plays
  # POST /game_plays.xml
  def create
    @game_play = GamePlay.new(params[:game_play])

    respond_to do |format|
      if @game_play.save
        format.html { redirect_to(@game_play, :notice => 'Game play was successfully created.') }
        format.xml  { render :xml => @game_play, :status => :created, :location => @game_play }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @game_play.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /game_plays/1
  # PUT /game_plays/1.xml
  def update
    @game_play = GamePlay.find(params[:id])

    respond_to do |format|
      if @game_play.update_attributes(params[:game_play])
        format.html { redirect_to(@game_play, :notice => 'Game play was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @game_play.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /game_plays/1
  # DELETE /game_plays/1.xml
  def destroy
    @game_play = GamePlay.find(params[:id])
    @game_play.destroy

    respond_to do |format|
      format.html { redirect_to(game_plays_url) }
      format.xml  { head :ok }
    end
  end
end
