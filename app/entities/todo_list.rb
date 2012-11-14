class TodoList
  include Entity

  attr_accessor :title
  attr_reader :todos

  def post_initialize(attributes)
    @todos ||= []
  end

  def add(new_todo)
    @todos << new_todo
  end

  def todo_by_id(todo_id)
    todos.find { |todo| todo.id == todo_id }
  end

  def move_todo(todo_id, destination_todo_list)
    todo_to_move = todo_by_id(todo_id)
    todos.delete todo_to_move
    destination_todo_list.add todo_to_move
  end
end
