var _todos = [];
var _callbacks = [];

var TodoStore = {

  all: function(){
    return _todos.slice();
  },

  find: function(title){
    return _todos.find(function(f){
      return f.title === title;
    });
  },

  fetch: function(){
    $.get('/api/todos', {}, function(todos){
      _todos = todos;
      TodoStore.changed();
    });
  },

  create: function(todo){
    var params = {todo: todo};
    $.post('/api/todos', params, function(todo){
      _todos.push(todo);
      TodoStore.changed();
    });
  },

  destroy: function(todo){
    var id = todo.id;
    $.ajax({
      url: '/api/todos/' + id,
      type: 'DELETE',
      success: function(todo){
        var index = _todos.indexOf(todo);
        _todos.splice(index, 1);
        TodoStore.changed();
      }
    });
  },

  toggleDone: function(todo){
    todo.done = !todo.done;
    var params = {todo: todo};
    var id = todo.id;
    $.ajax({
      url: '/api/todos/' + id,
      data: params,
      type: 'PATCH',
      success: function(todo){
      TodoStore.changed();
    }});
  },


  addChangeHandler: function(cb){
    _callbacks.push(cb);
  },

  removeChangeHandler: function(cb){
    var idx;

    for(var i = 0; i < _callbacks.length; i+=1){
      if(cb === _callbacks[i]){
        idx = i;
        break;
      }
    }

    if(!idx){ return; }

    _callbacks.splice(idx,1);
  },

  changed: function(){
    _callbacks.forEach(function(cb){
      cb();
    });
  }

};

module.exports = TodoStore;
