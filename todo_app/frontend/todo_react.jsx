var React = require('react');
var ReactDOM = require('react-dom');
var TodoList = require('./components/todo_list.jsx');


ReactDOM.render(
  <TodoList />,
  document.getElementById('app')
);
