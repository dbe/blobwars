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
    var delayBetweenDeltas = 1;
    
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
        $('body').append('<p id=' + counter + ' style="font-weight: bold;color:black;"></p>');
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
        $('#player-name').html(playerMap[gameHistory.winner[0]]);
        $('#player-name').css('color', colors[gameHistory.winner[0] + 2])
        
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