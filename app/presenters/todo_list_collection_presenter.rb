class TodoListCollectionPresenter
  attr_reader :list_id
  attr_reader :todos

  def initialize(list_id, todos)
    @list_id = list_id
    @todos = todos.map { |todo| TodoPresenter.new(todo, list_id) }
  end
end
