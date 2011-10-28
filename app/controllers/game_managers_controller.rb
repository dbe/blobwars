class GameManagersController < ApplicationController
  # GET /game_managers
  # GET /game_managers.xml
  def index
    @game_managers = GameManager.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @game_managers }
    end
  end

  # GET /game_managers/1
  # GET /game_managers/1.xml
  def show
    @game_manager = GameManager.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @game_manager }
    end
  end

  # GET /game_managers/new
  # GET /game_managers/new.xml
  def new
    @game_manager = GameManager.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @game_manager }
    end
  end

  # GET /game_managers/1/edit
  # def edit
  #     @game_manager = GameManager.find(params[:id])
  #   end

  # POST /game_managers
  # POST /game_managers.xml
  def create
    @game_manager = GameManager.new(params[:game_manager])

    respond_to do |format|
      if @game_manager.save
        format.html { redirect_to(@game_manager, :notice => 'Game manager was successfully created.') }
        format.xml  { render :xml => @game_manager, :status => :created, :location => @game_manager }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @game_manager.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /game_managers/1
  # PUT /game_managers/1.xml
  # def update
  #     @game_manager = GameManager.find(params[:id])
  # 
  #     respond_to do |format|
  #       if @game_manager.update_attributes(params[:game_manager])
  #         format.html { redirect_to(@game_manager, :notice => 'Game manager was successfully updated.') }
  #         format.xml  { head :ok }
  #       else
  #         format.html { render :action => "edit" }
  #         format.xml  { render :xml => @game_manager.errors, :status => :unprocessable_entity }
  #       end
  #     end
  #   end

  # DELETE /game_managers/1
  # DELETE /game_managers/1.xml
  # def destroy
  #     @game_manager = GameManager.find(params[:id])
  #     @game_manager.destroy
  # 
  #     respond_to do |format|
  #       format.html { redirect_to(game_managers_url) }
  #       format.xml  { head :ok }
  #     end
  #   end
  
  def play
    manager = GameManager.find(params[:id])
    redirect_to manager.play
  end
end
