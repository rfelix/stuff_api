require 'acceptance_spec_helper'

describe 'When obtaining the API root' do
  When { api_root_is_visited }

  #Then { show_me_the_json }
  Then { collection_href.should eq(last_request.url) }
  Then { available_list_titles.should include('Inbox') }
  Then { available_list_titles.should include('Today') }
  Then { available_list_titles.should include('Next') }

  def available_list_titles
    parsed_json['collection']['items'].map { |item| item['title'] }
  end
end
