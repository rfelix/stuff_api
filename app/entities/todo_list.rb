class TodoList
  include DynamicallyUpdatableAttributes

  attr_accessor :id
  attr_accessor :title

  def initialize(attributes = {})
    dynamically_update_attributes attributes
  end
end
