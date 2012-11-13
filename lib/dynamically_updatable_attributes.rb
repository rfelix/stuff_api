module DynamicallyUpdatableAttributes
  protected
  def dynamically_update_attributes(attrs)
    attrs.each do |name, value|
      writer_method = "#{name}="
      if self.respond_to?(writer_method, true)
        send writer_method, value
      elsif self.respond_to?(name, true)
        instance_variable_set "@#{name}".to_sym, value
      end
    end
  end
end
