var React = require('react');
var TodoStore = require('./../stores/todo_store.js');
var TodoListItem = require('./todo_list_item.jsx');
var TodoForm = require('./todo_form.jsx');

var TodoList = React.createClass({

  getInitialState: function(){
    return { todos: TodoStore.all() };

  },

  componentDidMount: function(){
    TodoStore.addChangeHandler(this.updateTodos);
    TodoStore.fetch();
  },

  updateTodos: function(){

    this.setState({ todos: TodoStore.all() });
  },

  render: function(){

    var list = this.state.todos.map(function(todo, index){

      return <TodoListItem todo={todo} key={todo.id}/>;
    }, this);

    return (

      <div>

        <ul>
          <p> Yo WHATUP </p>
          {
            list
          }

        </ul>

        <TodoForm />


      </div>

    );

  }


});

module.exports = TodoList;
