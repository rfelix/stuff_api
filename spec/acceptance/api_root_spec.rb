require 'acceptance_spec_helper'

describe 'Stuff API Root' do
  When { api_root_visited }

  #Then { show_me_the_json }
  Then { available_list_titles.should include('Inbox') }
  Then { available_list_titles.should include('Today') }
  Then { available_list_titles.should include('Next') }

  def api_root_visited
    get '/'
  end

  def available_list_titles
    parsed_json['collection']['items'].map { |item| item['title'] }
  end

  def parsed_json
    JSON.parse(last_response.body)
  end
end
