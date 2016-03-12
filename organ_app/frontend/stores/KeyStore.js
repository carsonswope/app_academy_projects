var AppDispatcher = require('../dispatcher/Dispatcher.js');
var Store = require('flux/utils').Store;

var KeyStore = new Store(AppDispatcher);

var _userKeys =     [];
var _recordedKeys = [];

KeyStore.all = function() {
  return _userKeys.concat(_recordedKeys);
};

KeyStore.addKey = function(key) {

  for (var i = 0; i < _userKeys.length; i++) {
    if (_userKeys[i] === key) { return; }
  }

  _userKeys.push(key);
  KeyStore.__emitChange();

};

KeyStore.removeKey = function(key) {

  var idx = undefined;

  for (var i = 0; i < _userKeys.length; i++) {
    if (_userKeys[i] === key) { idx = i; }
  }

  if (idx !== undefined) {
    _userKeys.splice(idx, 1);
    KeyStore.__emitChange();
  }

};

KeyStore.__onDispatch = function(payload){

  switch (payload.actionType) {
    case "ADD_KEY":
      KeyStore.addKey(payload.key);
      break;
    case "REMOVE_KEY":
      KeyStore.removeKey(payload.key);
      break;
    case "YIELD_TO_PLAYBACK":
      _recordedKeys = payload.keys;
      KeyStore.__emitChange();
  }

};

module.exports = KeyStore;
