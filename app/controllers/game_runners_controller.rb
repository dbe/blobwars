class GameRunnersController < ApplicationController
  # GET /game_runners
  # GET /game_runners.xml
  def index
    @game_runners = GameRunner.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @game_runners }
    end
  end

  # GET /game_runners/1
  # GET /game_runners/1.xml
  def show
    @game_runner = GameRunner.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @game_runner }
    end
  end

  # GET /game_runners/new
  # GET /game_runners/new.xml
  def new
    @game_runner = GameRunner.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @game_runner }
    end
  end

  # GET /game_runners/1/edit
  # def edit
  #     @game_runner = GameRunner.find(params[:id])
  #   end

  # POST /game_runners
  # POST /game_runners.xml
  def create
    @game_runner = GameRunner.new(params[:game_runner])

    respond_to do |format|
      if @game_runner.save
        format.html { redirect_to(@game_runner, :notice => 'Game runner was successfully created.') }
        format.xml  { render :xml => @game_runner, :status => :created, :location => @game_runner }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @game_runner.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /game_runners/1
  # PUT /game_runners/1.xml
  # def update
  #     @game_runner = GameRunner.find(params[:id])
  # 
  #     respond_to do |format|
  #       if @game_runner.update_attributes(params[:game_runner])
  #         format.html { redirect_to(@game_runner, :notice => 'Game runner was successfully updated.') }
  #         format.xml  { head :ok }
  #       else
  #         format.html { render :action => "edit" }
  #         format.xml  { render :xml => @game_runner.errors, :status => :unprocessable_entity }
  #       end
  #     end
  #   end

  # DELETE /game_runners/1
  # DELETE /game_runners/1.xml
  # def destroy
  #     @game_runner = GameRunner.find(params[:id])
  #     @game_runner.destroy
  # 
  #     respond_to do |format|
  #       format.html { redirect_to(game_runners_url) }
  #       format.xml  { head :ok }
  #     end
  #   end
  
  def play
    runner = GameRunner.find(params[:id])
    #make sure to load the classes file, then instantiate an instance of it
    load "runner/#{runner.game_runner_klass}.rb"
    game_runner_instance = Object.const_get(runner.game_runner_klass.classify).new
    
    i = 1
    clients = runner.game_clients.split.map do |c|
      # Lets reload each AI class for each run.
      load "ai/#{c}.rb"
      #create the AI instance with a new id
      Object.const_get(c.classify).new(i += 1)
    end
    
    history = game_runner_instance.play(*clients)
    history_record = runner.game_histories.create(:move_history => history[:deltas].map do |delta|
      {'x' => delta.x, 'y' => delta.y, 'team' => delta.team}
    end, :winner => history[:winner])
    redirect_to history_record
  end
end
