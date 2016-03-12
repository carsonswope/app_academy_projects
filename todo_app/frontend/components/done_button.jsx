var React = require('react');
var TodoStore = require('./../stores/todo_store.js');

var DoneButton = React.createClass({

  handleDoneClick: function(e){
    TodoStore.toggleDone(this.props.todo);
  },


  render: function(){

    var done = "";
    if (this.props.todo.done) {
      done = "undo";
    } else {
      done = "done";
    }


    return (
      <div>
        <button type="button" onClick={this.handleDoneClick}>{done}</button>
      </div>
    );

  }

});

module.exports = DoneButton;
