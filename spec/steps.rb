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

def item_href_is_visited(match_options = {})
  api_root_is_visited

  if match_options.empty?
    matched_item = parsed_collection.items.first
  else
    matched_item = parsed_collection.items.find { |item|
      match_options.all? { |field_name, value| item.data[field_name].value == value }
    }
  end
  matched_item.href.should_not be_empty
  get matched_item.href
end

### Response parsing steps

def parsed_collection
  CollectionJSON.parse(last_response.body)
end

### Creation steps

def existing_todos_in_inbox
  inbox_list = todo_list_repository.list_all.find { |todo_list| todo_list.title == 'Inbox' }
  @existing_todos = [Todo.new(title: 'Build Hypermedia API', notes: 'Test', due_date: Date.new(2012, 11, 15))]
  @existing_todos.each do |new_todo|
    inbox_list.add new_todo
  end
  todo_list_repository.update inbox_list
end
