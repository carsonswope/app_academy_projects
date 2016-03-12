var Tones = {

  frequenciesAtThirdOctave: {
    A:  220,
    Bb: 233.08,
    B:  246.94,
    C:  261.63,
    Db: 277.18,
    D:  293.66,
    Eb: 311.13,
    E:  329.63,
    F:  349.23,
    Gb: 369.99,
    G:  392.00,
    Ab: 415.30
  },

  frequency: function(note, octave) {
    var freqAtThird = this.frequenciesAtThirdOctave[note];
    if (!octave) { octave = 3 ; }
    return Math.pow(2, octave - 3) * freqAtThird;
  },

  fullOctave: function() {
    return Object.keys(this.frequenciesAtThirdOctave);
  }
};

module.exports = Tones;
