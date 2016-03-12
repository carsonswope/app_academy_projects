var KeyActions = require('../actions/KeyActions.js');

var mapping = {

  81: 'A',
  87: 'Bb',
  69: 'B',
  82: 'C',
  84: 'Db',
  89: 'D',
  85: 'Eb',
  73: 'E',
  79: 'F',
  80: 'Gb',
  219: 'G',
  221: 'Ab'

};

$('.keyboard').on('keydown', function(e){

  KeyActions.keyPressed(
    mapping[e.keyCode]
  );

});

$('.keyboard').on('keyup', function(e){

  KeyActions.keyUp(
    mapping[e.keyCode]
  );

});
