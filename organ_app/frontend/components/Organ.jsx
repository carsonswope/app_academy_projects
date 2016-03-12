var React = require('react');
var OrganKey = require('./OrganKey.jsx');
var Tones = require('../constants/Tones.js');
var Recorder = require('./Recorder.jsx');
var Jukebox = require('./Jukebox.jsx');
var TrackStore = require('../stores/TrackStore.js');

var Organ = React.createClass({

  hi: function() {
    debugger;

  },

  render: function() {

    var keys = Tones.fullOctave().map(function(noteName) {
      return <OrganKey
                key={noteName}
                noteName={noteName}
              />;
    });

    return(
      <div className="organ">
        <div className="keyboard" tabIndex="0">
          {keys}
        </div>
        <Recorder />
        <Jukebox />
      </div>
    );

  }

});

module.exports = Organ;
