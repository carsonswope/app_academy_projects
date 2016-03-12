var ReactDOM = require('react-dom');
var React = require('react');
var Organ = require('./components/Organ.jsx');



$(function() {

  ReactDOM.render(
    <Organ />,
    document.getElementById('organ')
  );

  require('./util/KeyListener.js');

});
