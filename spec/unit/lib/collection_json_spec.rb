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

      context "when parsing item's links" do
        let(:link) { item.links['item-link'] }

        it 'parses the link rel' do
          link.rel.should == 'item-link'
        end

        it 'parses the link href' do
          link.href.should == 'http://item/link'
        end

        it 'parses the link prompt' do
          link.prompt.should == 'Item Link'
        end
      end
    end

    context 'when parsing collection template' do
      it 'can build the template by filling in the fields' do
        data = collection.build_template('dfield' => 'New Value')

        dfield = data['template']['data'].find { |data_field| data_field['name'] == 'dfield' }
        dfield.should_not be_nil
        dfield['value'].should == 'New Value'

        dfield2 = data['template']['data'].find { |data_field| data_field['name'] == 'dfield2' }
        dfield2.should_not be_nil
        dfield2['value'].should == 'dfield_value2'
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
        ],
        "links": [
          {"rel": "item-link", "href": "http://item/link", "prompt": "Item Link"}
        ]
      }
    ],
    "template": {
      "data": [
        {"name": "dfield", "value": "dfield_value", "prompt": "DField"},
        {"name": "dfield2", "value": "dfield_value2", "prompt": "DField2"}
      ]
    }
  }
}
    json
  end
end
