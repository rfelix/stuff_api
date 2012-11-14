class TodoPresenter
  extend Forwardable

  attr_reader :list_id

  def_delegator :@todo, :id, :id
  def_delegator :@todo, :title, :title
  def_delegator :@todo, :notes, :notes

  def initialize(todo, todo_list_id)
    @todo = todo
    @list_id = todo_list_id
  end

  def due_date
    @todo.due_date.strftime('%Y-%m-%d') if @todo.due_date
  end
end
