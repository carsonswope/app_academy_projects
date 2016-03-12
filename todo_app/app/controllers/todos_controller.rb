class TodosController < ApplicationController

  def index
    render json: Todo.all
  end

  def create
    todo = Todo.create!(todo_params)
    render json: todo
  end

  def destroy
    todo = Todo.find_by_id(params[:id])
    todo.destroy!
    render json: todo
  end

  def update
    todo = Todo.find_by_id(params[:id])
    todo.update!(todo_params)
    render json: todo
  end

  def show
    todo = Todo.find_by_id(params[:id])
    render json: todo
  end

  def todo_params
    params.require(:todo).permit(:title, :body, :done)
  end

end
