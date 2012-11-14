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

    def build_template(fields = {})
      result = {'template' => {'data' => []}}
      collection['template']['data'].each do |field|
        filled_field = field.dup
        filled_field['value'] = fields[field['name']] if fields.has_key?(field['name'])
        result['template']['data'] << filled_field
      end
      result
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

    def links
      return @links unless @links.nil?
      @links = {}
      item['links'].each do |link|
        @links[link['rel']] = Link.new(link)
      end
      @links
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

  class Link
    private
    attr_reader :link

    public
    def initialize(parsed_link)
      @link = parsed_link
    end

    def rel
      @link['rel']
    end

    def href
      @link['href']
    end

    def prompt
      @link['prompt']
    end
  end
end
