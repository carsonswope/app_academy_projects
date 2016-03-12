var KeyActions = require('../actions/KeyActions.js');

var Track = function(options) {
  if (!options.name) {options.name = '';}
  this.name = options.name;
  if (!options.roll) {options.roll = [];}
  this.roll = options.roll;
  this.id = options.id;
};

Track.prototype.startRecording = function() {
  this.roll = [];
  this.startTime = new Date().getTime();
  this.recording = true;
};

Track.prototype.stopRecording = function() {
  this.addNotes([]);
  this.recording = false;
};

Track.prototype.addNotes = function(notes) {
  if (this.recording) {
    var timeSlice = new Date().getTime() - this.startTime;
    this.roll.push({
      time: timeSlice,
      notes: notes
    });
  }
};

Track.prototype.play = function() {

  if (this.interval) {

    clearInterval(this.interval);
    this.interval = undefined;

  }

  var playbackStartTime = new Date().getTime();
  var currentNote = 0;
  var currentTime = 0;

  this.interval = setInterval(function(){

    currentTime = new Date().getTime() - playbackStartTime;

    if (!this.roll[currentNote]) {
      clearInterval(this.interval);
      this.interval = undefined;
    } else if (this.roll[currentNote].time < currentTime) {
      KeyActions.playKeys(this.roll[currentNote].notes);
      currentNote += 1;
    }
  }.bind(this), 10);

};

module.exports = Track;
