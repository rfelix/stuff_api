module Entity
  include DynamicallyUpdatableAttributes

  attr_accessor :id

  def initialize(attributes = {})
    dynamically_update_attributes attributes
    post_initialize attributes
  end

  def post_initialize(attributes)
    # Can be overriden to extend initialization process
  end
end
