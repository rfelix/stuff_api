class TodoMover
  private
  attr_reader :todo_list_repository

  public
  def initialize(options = {})
    @todo_list_repository = options.fetch(:todo_list_repository)
  end

  def move_todo(options = {})
    current_todo_list = todo_list_repository.find_by_id(options.fetch(:current_todo_list_id))
    destination_todo_list = todo_list_repository.find_by_id(options.fetch(:destination_todo_list_id))

    current_todo_list.move_todo(options.fetch(:todo_id), destination_todo_list)

    todo_list_repository.update current_todo_list
    todo_list_repository.update destination_todo_list
  end
end
