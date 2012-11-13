### Generic steps useful for testing APIs

def parsed_json
  JSON.parse(last_response.body)
end

### Steps when debug is needed

def show_me_the_response
  puts last_response.body
end

def show_me_the_json
  puts JSON.pretty_generate(parsed_json)
end

### Navigation steps

def api_root_is_visited
  get '/'
end

def item_href_is_visited(&item_matcher)
  api_root_is_visited

  item = parsed_json['collection']['items'].find(&item_matcher)
  get item['href']
end

### Response parsing steps

def collection_href
  parsed_json['collection']['href']
end
