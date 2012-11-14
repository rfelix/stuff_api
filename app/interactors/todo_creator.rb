class TodoCreator
  private
  attr_reader :todo_list_repository

  public
  def initialize(options = {})
    @todo_list_repository = options.fetch(:todo_list_repository)
  end

  def create_todo(options = {})
    todo_list = todo_list_repository.find_by_id(options.fetch(:todo_list_id))
    todo = Todo.from_hash(options.fetch(:data))

    todo_list.add todo
    todo_list_repository.update(todo_list)
    todo.id
  end
end
