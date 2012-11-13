require 'json'

module CollectionJSON
  def self.parse(json)
    parsed_json = JSON.parse(json)
    Collection.new(parsed_json['collection'])
  end

  class Collection
    private
    attr_reader :collection

    public
    def initialize(parsed_collection)
      @collection = parsed_collection
    end

    def href
      collection['href']
    end

    def items
      collection['items'].map { |item| Item.new item }
    end
  end

  class Item
    private
    attr_reader :item

    public
    def initialize(parsed_item)
      @item = parsed_item
    end

    def href
      item['href']
    end

    def data
      return @data unless @data.nil?
      @data = {}
      item['data'].each do |data_field|
        @data[data_field['name']] = DataField.new(data_field)
      end
      @data
    end
  end

  class DataField
    private
    attr_reader :data_field

    public
    def initialize(parsed_data_field)
      @data_field = parsed_data_field
    end

    def name
      @data_field['name']
    end

    def value
      @data_field['value']
    end

    def prompt
      @data_field['prompt']
    end
  end
end
