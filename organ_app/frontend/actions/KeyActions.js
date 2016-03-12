var AppDispatcher = require('../dispatcher/Dispatcher.js');

var KeyActions = {

  keyPressed: function(key) {
    AppDispatcher.dispatch({
      actionType: "ADD_KEY",
      key: key
    });
  },

  keyUp: function(key) {
    AppDispatcher.dispatch({
      actionType: "REMOVE_KEY",
      key: key
    });
  },

  playKeys: function(keys) {
    AppDispatcher.dispatch({
      actionType: "YIELD_TO_PLAYBACK",
      keys: keys
    });
  }

};

module.exports = KeyActions;
