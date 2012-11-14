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

  def list_move_destinations(user, todo_list_id, todo_id)
    possible_destinations = todo_list_repository.list_all
    possible_destinations.delete_if { |todo_list| todo_list.id == todo_list_id }
    possible_destinations
  end
end
