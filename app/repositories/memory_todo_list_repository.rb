class MemoryTodoListRepository
  private
  attr_reader :records

  public
  def initialize(skip_record_initialization = false)
    @id_counter = 0
    @todo_id_counter = 0
    @records = {}
    initialize_default_records if !skip_record_initialization
  end

  def find_by_id(id)
    records[id]
  end

  def create(obj)
    store obj
  end

  def update(obj)
    store obj
  end

  def list_all
    records.values
  end

  private
  def store(obj)
    obj.id ||= (@id_counter += 1)
    @records[obj.id] = obj.dup
    obj.todos.each do |todo|
      todo.id ||= (@todo_id_counter += 1)
    end
  end

  def initialize_default_records
    # This needs to be done because this is a memory repository. If it were
    # persisted this step would be done before booting up the application
    %w(Inbox Today Next).each do |title|
      store TodoList.new(title: title).tap { |l| l.add Todo.new(title: "Todo in #{title}") }
    end
  end
end
