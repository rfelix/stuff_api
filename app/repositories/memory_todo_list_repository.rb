class MemoryTodoListRepository
  private
  attr_reader :records

  public
  def initialize(skip_record_initialization = false)
    @id_counter = 0
    @records = {}
    initialize_default_records if !skip_record_initialization
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
    @records[obj.id] = obj
  end

  def initialize_default_records
    # This needs to be done because this is a memory repository. If it were
    # persisted this step would be done before booting up the application
    %w(Inbox Today Next).each do |title|
      store TodoList.new title: title

    end
  end
end
