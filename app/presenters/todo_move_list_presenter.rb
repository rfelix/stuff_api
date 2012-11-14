class TodoMoveListPresenter
  attr_reader :todo_id
  attr_reader :todo_list_id
  attr_reader :todo_lists

  def initialize(todo_move_list, todo_list_id, todo_id)
    @todo_id = todo_id
    @todo_list_id = todo_list_id
    @todo_lists = todo_move_list
  end
end
