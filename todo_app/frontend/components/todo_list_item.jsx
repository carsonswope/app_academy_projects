var React = require('react');
var TodoStore = require('./../stores/todo_store.js');
var DoneButton = require('./done_button.jsx');

var TodoListItem = React.createClass({

  handleDeleteClick: function(e){
    TodoStore.destroy(this.props.todo);
  },


  render: function(){


    return (
      <div>
        {this.props.todo.title}
        <button type="button" onClick={this.handleDeleteClick}>Delete</button>
        <DoneButton todo={this.props.todo} />
      </div>
    );

  }


});

module.exports = TodoListItem;
