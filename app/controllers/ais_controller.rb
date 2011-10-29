class AisController < ApplicationController
  # GET /ais
  # GET /ais.xml
  def index
    @ais = Player.find(params[:player_id]).ais.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ais }
    end
  end

  # GET /ais/1
  # GET /ais/1.xml
  def show
    @ai = Player.find(params[:player_id]).ais.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ai }
    end
  end

  # GET /ais/new
  # GET /ais/new.xml
  def new
    @ai = Player.find(params[:player_id]).ais.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ai }
    end
  end

  # GET /ais/1/edit
  def edit
    @ai = Player.find(params[:player_id]).ais.find(params[:id])
  end

  # POST /ais
  # POST /ais.xml
  def create
    @ai = Player.find(params[:player_id]).ais.new(params[:ai])

    respond_to do |format|
      if @ai.save
        format.html { redirect_to([@ai.player, @ai], :notice => 'Ai was successfully created.') }
        format.xml  { render :xml => @ai, :status => :created, :location => @ai }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ai.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ais/1
  # PUT /ais/1.xml
  def update
    @ai = Player.find(params[:player_id]).ais.find(params[:id])

    respond_to do |format|
      if @ai.update_attributes(params[:ai])
        if g = Game.trigger
          format.html { redirect_to(g, :notice => 'Game was triggered.') }
          format.xml  { head :ok }
        else
          format.html { redirect_to([@ai.player, @ai], :notice => 'Ai was successfully updated.') }
          format.xml  { head :ok }
        end
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ai.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ais/1
  # DELETE /ais/1.xml
  def destroy
    @ai = Player.find(params[:player_id]).ais.find(params[:id])
    @ai.destroy

    respond_to do |format|
      format.html { redirect_to(ais_url) }
      format.xml  { head :ok }
    end
  end
end
