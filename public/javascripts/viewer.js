$(document).ready(function() {
  $('body').prepend("<canvas id='viewer' width='500' height='500'> Please get a browser which supports canvas </canvas>");
  $canvas = $('canvas');
  blobwars($canvas);
});

gameHistory = {
  resolution : {x : 500, y: 500},
  deltas : [
    {x : 1, y: 1, team : 0},
    {x : 2, y: 1, team : 2},
    {x : 10, y: 1, team : 3},
    {x : 4, y: 1, team : 4},
    {x : 5, y: 1, team : 5}
  ]
};
colors = ['#f00', 'green', 'red', 'pink'];



function blobwars($canvas) {
  var context = $canvas[0].getContext('2d');
  
  var width = gameHistory.resolution.x;
  var height = gameHistory.resolution.y; 
  
  var currentDelta = 0;
  
  $canvas.click(function() {
    paintNextState();
    currentDelta++;
  });
  
  function paintNextState() {
    var delta = gameHistory.deltas[currentDelta];
    context.fillStyle = colors[delta.team];
    context.fillRect(delta.x, delta.y, 1, 1);
  }
  
}