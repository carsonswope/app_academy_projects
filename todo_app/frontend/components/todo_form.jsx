var React = require('react');
TodoStore = require('./../stores/todo_store.js');
var TodoForm = React.createClass({


  getInitialState: function(){

    return {newTitle: "", newBody: ""};

  },

  handleTitle: function(e){
    this.setState({ newTitle: e.target.value })
  },

  handleBody: function(e){
      this.setState({ newBody: e.target.value });
    },

  handleNewTodo: function(e){
    e.preventDefault();

    var newTodo = {
      title: this.state.newTitle,
      body: this.state.newBody,
      done: false
    };

    TodoStore.create(newTodo);

    this.setState({
      newTitle: "",
      newBody: "",
    });
  },




  render: function(){

    return (
      <div>
    <h2>New Todo</h2>
    <form onSubmit={this.handleNewTodo}>

      Title: <input type="text"
                   onChange={this.handleTitle}
                   value={this.state.newTitle}/>
      <br/>

      Body: <input type="text"
                    onChange={this.handleBody}
                    value={this.state.newBody}/>
      <br/>

      <input type="submit" value="New Todo"/>
    </form>
  </div>
    );

  }


});

module.exports = TodoForm;
