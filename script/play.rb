puts "You must specify <WIDTH> <HEIGHT> and at least 2 ai filenames!" or exit unless ARGV.size >= 4
WIDTH,HEIGHT,*ai_file_names = ARGV

require File.expand_path('../../config/environment.rb',  __FILE__)

require 'game/game_runner.rb'

class AiProgramWrapper
  attr_reader :team, :ai
  def initialize pipe, team
    @ai = pipe
    @team = team
  end
  def get_move move
    @ai.puts move.board.to_comma_seperated_string
    output = @ai.gets
    output.chop.split(',').map(&:to_i) # => [x,y]
  end
end

i = 1
ais = ai_file_names.map do |fname|
  i += 1
  AiProgramWrapper.new(IO.popen("python #{fname} #{i}", 'r+'), i)
end

output = GameRunner.new.play(ais, WIDTH.to_i, HEIGHT.to_i).to_json


File.open("loltestsite.html", "w+") do |f|
f.puts <<-website

<!DOCTYPE html>
<html>
<head>
  <title>BlobWars</title>
  <link href="/stylesheets/scaffold.css?1319666693" media="screen" rel="stylesheet" type="text/css" />
  <meta name="csrf-param" content="authenticity_token"/>
<meta name="csrf-token" content="4cm0jrmthiiLF76mpYbpHnJZqyzdhWY1MqqzAbt5z9c="/>
</head>
<body>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript">
BlobWars = (function() {
  var idealResolution = {x : 600, y: 600};
  var colors = ['white', 'black', 'green', 'blue', 'red', 'purple'];
  var playerMap = ["Brian", "Danny", "Michel", "Gareth"];
  counter = 0;
  
  
  function validGameHistory(gameHistory) {
    if(gameHistory.dimensions.x > idealResolution.x || gameHistory.dimensions.y > idealResolution.y)
    {
      console.log("Cannot render this game, its resolution is incompatible");
      return false;
    }
    return true;
  }
  
  function getScalingFactor(dimensions) {
    return {x : Math.floor((idealResolution.x / dimensions.x)), y :Math.floor((idealResolution.y / dimensions.y))};
  } 
   
  //constructs and returns a canvas object
  function constructCanvasElement(dimensions, scalingFactor, divID) {
    $('#' + divID).append("<canvas id='history_viewer' width='" + (dimensions.x * scalingFactor.x) + "' height='" + (dimensions.y * scalingFactor.y) + "'> Please get a browser which supports canvas, foo </canvas>");
    return $('#history_viewer')[0];
  }
  
  function RenderQueue() {
    //list of {:time => time in millis in which to run this thing, :callback => function to run}
    this.queue = [];
    this.add = function(timeToExecute, f, thisVar) {
      this.queue.push({time : timeToExecute, f : f, thisVar : thisVar, args : Array.prototype.slice.call(arguments, 3)});
    }
    this.runValidFunctions = function() {
      var timeNow = new Date().getTime();
      for(var i = 0; i < this.queue.length; i++)
      {
        //Time to run this function
        if(this.queue[i].time < timeNow){
          var object = this.queue.splice(i, 1)[0];
          object.f.apply(object.thisVar, object.args);
        }
      }
    }
    //Warning, this might cause some memory leak
    this.clearQueue = function() {
      this.queue = [];
    }
  }
  
  function Viewer(canvas, gameHistory, scalingFactor) {
    var context = canvas.getContext('2d');
    var canvasDimensions = {x : (gameHistory.dimensions.x * scalingFactor.x), y : (gameHistory.dimensions.y * scalingFactor.y) };
    var renderQueue = new RenderQueue();
    var renderQueueIntervalID = setInterval(function(){renderQueue.runValidFunctions.call(renderQueue)}, (1000/60));
    //setInterval(function(){console.log(renderQueue.queue)},50);
    var currentTurn = 1;
    var delayBetweenTurns = 20;
    var delayBetweenDeltas = 15;
    
    function animateDeltas(deltas, delay, onComplete) {
      var timeNow = new Date().getTime();
      if(deltas.length === 0){onComplete();}
      for(var i = 0; i < deltas.length; i++)
      {
        //only call onComplete to the final function call
        if(i < deltas.length - 1)
        {
          renderQueue.add(timeNow + (delay * i), paintDelta, this, deltas[i]);
        }
        else
        {      
          renderQueue.add(timeNow + (delay * i), paintDelta, this, deltas[i], onComplete);
        }
      }
    }
    
    var paintDelta = function(delta, onComplete) {
      context.fillStyle = colors[delta.objectID];
      if(!spaceIsEmpty(delta.x, delta.y))
      {
        var offset = $('canvas').offset();
        var message = (delta.objectID == 1) ? 'Wall' : 'Captured!'
        console.log(message);
        $('body').append('<p id=' + counter + ' style="font-weight: bold;color:black;">' + message + '</p>');
        $('#' + counter).css({'position': 'fixed', 'left' : offset.left + (delta.x * scalingFactor.x), 'top' : offset.top + (delta.y * scalingFactor.y), 'z-index' : 100});
        $('#' + counter).animate({
          left: '-=20',
          top: '-=20',
          opacity: 0
        }, 500, function(e) {
          $(this).remove();
        });
        counter++;
        console.log("Would have shown capture animation");
      }
      context.fillRect(delta.x * scalingFactor.x, delta.y * scalingFactor.y, scalingFactor.x, scalingFactor.y);
      onComplete && onComplete();
    }
    
    var clearBoard = function() {
      context.clearRect(0, 0, canvasDimensions.x, canvasDimensions.y);
    }
    
    //Give in game coords
    var spaceIsEmpty = function(x,y) {
      var data = context.getImageData(x * scalingFactor.x, y * scalingFactor.y, 1, 1).data
      //each pixel value is 255(white) or the alpha value is 0 (fully transparent)
      return (data[0] + data[1] + data[2] === 765) || (data[3] == 0)
    }
    
    //Get this out of the JS file!
    var displayPlayerName = function(turn) {
      $('#player-name').html(playerMap[turn.playerID]);
      $('#player-name').css('color', colors[turn.playerID + 2])
    }
    
    var playTurn = function(onComplete) {
      var turn = gameHistory.turns[currentTurn - 1];
      displayPlayerName(turn);
      animateDeltas(turn.deltas, delayBetweenDeltas, onComplete)
    }
    
    var play = function() {
      if(currentTurn <= gameHistory.turns.length)
      {
        if(delayBetweenTurns == 0) 
        {
          playTurn(function(){currentTurn++;play();});
        }
        else
        {
          setTimeout(playTurn, delayBetweenTurns, function(){currentTurn++;play();})
        }
      }
      else
      {
        $('#player-header').html("Winner:");
        $('#player-name').html(playerMap[gameHistory.winners[0]]);
        $('#player-name').css('color', colors[gameHistory.winners[0] + 2])
        
        console.log("Finished");
      }
    }
    
    this.playFromBeginning = function() {
      clearBoard();
      $('#player-header').html("Player:");
      currentTurn = 1;
      play();
    }
    
    this.playFromTurn = function(turnNumber) {
      //init board
      clearBoard(); //take this out once I have init board working
      currentTurn = turnNumber;
      play();
    }
    
    this.setDelayBetweenTurns = function(millis) {
      delayBetweenTurns = millis;
    }
    
    this.getDelayBetweenTurns = function() {
      return delayBetweenTurns;
    }    
  }
  
  return {
    //Returns new Viewer object for the view to use
    initialize : function(gameHistory, canvasDivID) {
      if(!validGameHistory){return false};
      var scalingFactor = getScalingFactor(gameHistory.dimensions);
      canvas = constructCanvasElement(gameHistory.dimensions, scalingFactor, canvasDivID);
      return new Viewer(canvas, gameHistory, scalingFactor);
    }
  }  
})();
</script>
<div id='left'></div>
<div id='right'></div>
<div id='content'>
  <div id='player'>
    <h1 id='player-header'>Player:</h1>
    <h3 id='player-name'>Player Name</h3>
  </div>
  <div id='viewer'></div>
  <div id='control-panel'>
    <label for="playback-speed">Playback Speed:</label>
    <input id="playback-speed" name="playback-speed" type="text" />
  </div>
</div>
<script>
  //<![CDATA[
    $(document).ready(function() {
      gameHistory = #{output}
      viewer = BlobWars.initialize(gameHistory, 'viewer');
      $('canvas').click(function() {
        viewer.playFromBeginning();
      });      
    });
  //]]>
</script>
<style>
  #left {
    background: -moz-linear-gradient(center top, #a92c10, #bd3112);
    width: 500px;
    height: 100%;
    position: fixed;
    top: 0px;
    left: 0px;
    z-index: 1; }
  
  #right {
    background-color: #b6a682;
    width: 100%;
    height: 100%;
    position: fixed;
    top: 0px;
    left: 500px;
    z-index: 1; }
  
  #content {
    text-align: center;
    font-family: Arial, sans-serif;
    z-index: 100;
    position: relative; }
  
  canvas {
    border: 1px solid;
    background-color: #dddddd; }
  
  #control-panel {
    background: -moz-linear-gradient(center top, #9fc8db, #5d747f);
    background-color: #cccccc;
    border: 1px solid;
    width: 100%; }
  
  h1 {
    font-size: 40px; }
  
  label {
    font-weight: bold; }
</style>


</body>
</html>
website
end

puts "Produced game."

ais.each do |ai|
  ai.ai.close
end