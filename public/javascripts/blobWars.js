BlobWars = (function() {
  var idealResolution = {x : 600, y: 600};
  var colors = ['red', 'green', 'blue', 'grey', 'purple'];
  
  
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
    var delayBetweenTurns = 50;
    var delayBetweenDeltas = 500;
    
    function animateDeltas(deltas, delay, onComplete) {
      var timeNow = new Date().getTime();
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
    
    var playTurn = function(onComplete) {
      var turn = gameHistory.turns[currentTurn - 1];
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
    }
    
    this.playFromBeginning = function() {
      clearBoard();
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
    initialize : function(gameHistory, divID) {
      if(!validGameHistory){return false};
      var scalingFactor = getScalingFactor(gameHistory.dimensions);
      canvas = constructCanvasElement(gameHistory.dimensions, scalingFactor, divID);
      return new Viewer(canvas, gameHistory, scalingFactor);
    }
  }  
})();