class TodoLister
  private
  attr_reader :todo_list_repository

  public
  def initialize(options = {})
    @todo_list_repository = options.fetch(:todo_list_repository)
  end

  def list_all(user, todo_list_id)
    todo_list = todo_list_repository.find_by_id(todo_list_id)
    todo_list.todos
  end

  def list_one(user, todo_list_id, todo_id)
    todo_list = todo_list_repository.find_by_id(todo_list_id)
    todo_list.todo_by_id(todo_id)
  end
end
