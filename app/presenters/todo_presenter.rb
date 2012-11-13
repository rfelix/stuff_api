class TodoPresenter
  extend Forwardable

  def_delegator :@todo, :title, :title
  def_delegator :@todo, :notes, :notes

  def initialize(todo)
    @todo = todo
  end

  def due_date
    @todo.due_date.strftime('%Y-%m-%d') if @todo.due_date
  end
end
