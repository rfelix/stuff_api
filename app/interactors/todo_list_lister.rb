class TodoListLister
  private
  attr_reader :todo_list_repository

  public
  def initialize(options = {})
    @todo_list_repository = options.fetch(:todo_list_repository)
  end

  def list_all(user)
    todo_list_repository.list_all
  end
end
