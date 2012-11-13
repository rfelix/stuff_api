require 'spec_helper'

describe CollectionJSON do
  describe '.parse' do
    subject(:collection) { CollectionJSON.parse(sample_collection_json) }

    it 'parses the collection structure' do
      collection.href.should_not be_nil
      collection.items.should have(1).item
    end

    it 'parses the collection href' do
      collection.href.should == 'http://collection'
    end

    context "when parsing collection's items" do
      let(:item) { collection.items.first }

      it 'parses the item href' do
        item.href.should == 'http://item'
      end

      it "indexes the item's data by its name" do
        item.data['field'].should_not be_nil
      end

      context "when parsing item's data" do
        let(:data_field) { item.data['field'] }

        it 'parses the data field name' do
          data_field.name.should == 'field'
        end

        it 'parses the data field value' do
          data_field.value.should == 'field_value'
        end

        it 'parses the data field prompt' do
          data_field.prompt.should == 'Field'
        end
      end
    end
  end

  def sample_collection_json
    <<-json
{
  "collection": {
    "href": "http://collection",
    "items": [
      {
        "href": "http://item",
        "data": [
          {
            "name": "field",
            "value": "field_value",
            "prompt": "Field"
          }
        ]
      }
    ]
  }
}
    json
  end
end
