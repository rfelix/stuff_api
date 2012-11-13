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
end
