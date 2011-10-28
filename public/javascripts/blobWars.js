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
    $('#' + divID).append("<canvas id='history_viewer' width='" + dimensions.x * scalingFactor.x + "' height='" + dimensions.y * scalingFactor.y + "'> Please get a browser which supports canvas, foo </canvas>");
    return $('#history_viewer')[0];
  }
   
  function Viewer(canvas, gameHistory, scalingFactor) {
    var context = canvas.getContext('2d');
    
    function printDeltas(deltas) {
      for(var i = 0; i < deltas.length; i++)
      {
        printDelta(deltas[i]);
      }
    }
    
    function printDelta(delta) {
      context.fillStyle = colors[delta.objectID];
      context.fillRect(delta.x * scalingFactor.x, delta.y * scalingFactor.y, scalingFactor.x, scalingFactor.y);
    }
    
    this.paintTurn = function(turnNumber) {
      var turn = gameHistory.turns[turnNumber - 1];
      console.log("Printing turn for player : " + turn.playerID);
      printDeltas(turn.deltas);
    }
  }
   
  
  return {
    //Returns new Viewer object for the view to use
    initialize : function(gameHistory, divID) {
      if(!validGameHistory){return false};
      var scalingFactor = getScalingFactor(gameHistory.dimensions);
      canvas = constructCanvasElement(gameHistory, scalingFactor, divID);
      return new Viewer(canvas, gameHistory, scalingFactor); 
    }
  }
})();