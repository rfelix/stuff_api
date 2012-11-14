class Todo
  include Entity

  attr_accessor :title
  attr_accessor :notes
  attr_accessor :due_date
  attr_accessor :completed

  def self.from_hash(hash)
    hash = hash.dup
    hash['due_date'] = Date.parse(hash['due_date']) if hash['due_date']
    hash['completed'] = force_boolean_value(hash['completed'])
    self.new(hash)
  end

  private
  def self.force_boolean_value(value)
    if value == true || value =~ (/(true|t|yes|y|1)$/i)
      true
    else
      false
    end
  end
end
