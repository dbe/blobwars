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
   
  function Viewer(canvas, gameHistory, scalingFactor) {
    var context = canvas.getContext('2d');
    var canvasDimensions = {x : (gameHistory.dimensions.x * scalingFactor.x), y : (gameHistory.dimensions.y * scalingFactor.y) };
    var currentTurn = 1;
    var playing = false;
    
    function animateDeltas(deltas, i, delay, callback) {
      paintDelta(deltas[i++]);
      if(i < deltas.length)
      {
        setTimeout(animateDeltas, delay, deltas, i, delay, callback);
      }
      else
      {
        currentTurn++;
        setTimeout(callback, delay);
      }
    }
    
    function paintDelta(delta) {
      context.fillStyle = colors[delta.objectID];
      context.fillRect(delta.x * scalingFactor.x, delta.y * scalingFactor.y, scalingFactor.x, scalingFactor.y);
    }
    
    function play() {
      if(playing) 
      {
        animateDeltas(gameHistory.turns[currentTurn - 1].deltas, 0, 50, play);
      }
    }
    
    // this.paintTurn = function(turnNumber, delayPerDelta) {
    //   this.clearBoard();
    //   var turn = gameHistory.turns[turnNumber - 1];
    //   animateDeltas(turn.deltas, 0, delayPerDelta);
    // }
    
    this.playFromBeginning = function() {
      this.clearBoard();
      currentTurn = 1;
      playing = true;
      play();
    }
    
    //Make this private possibly
    this.clearBoard = function() {
      context.clearRect(0, 0, canvasDimensions.x, canvasDimensions.y);
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