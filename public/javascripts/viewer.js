function blobWars($canvas, gameHistory, scalingFactor) {
  var colors = ['#f00', 'green', 'red', 'pink'];
  var context = $canvas[0].getContext('2d');
  var currentDelta = 0;
  
  $canvas.click(function() {
    paintTurn(currentDelta);
    currentDelta++;
  });
  
  function paintTurn(deltaNumber) {
    var delta = gameHistory.deltas[deltaNumber];
    context.fillStyle = colors[delta.team];
    context.fillRect(delta.x * scalingFactor.x, delta.y * scalingFactor.y, scalingFactor.x, scalingFactor.y);
  }
  
}
