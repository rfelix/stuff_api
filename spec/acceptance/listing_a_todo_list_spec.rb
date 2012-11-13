require 'acceptance_spec_helper'

describe 'When listing a Todo List' do
  Given(:todo_list_repository) { MemoryTodoListRepository.singleton }
  Given { existing_todos_in_inbox }

  When { inbox_todo_list_href_is_followed }

  Then { show_me_the_json }
  Then { collection_href.should eq(last_request.url) }
  Then { existing_todos_can_be_seen }

  def existing_todos_in_inbox
    inbox_list = todo_list_repository.list_all.find { |todo_list| todo_list.title == 'Inbox' }
    @existing_todos = [Todo.new(title: 'Build Hypermedia API')]
    @existing_todos.each do |new_todo|
      inbox_list.add new_todo
    end
    todo_list_repository.update inbox_list
  end

  def inbox_todo_list_href_is_followed
    get '/'
    inbox_item = parsed_json['collection']['items'].find { |item| item['title'] == 'Inbox' }
    get inbox_item['href']
  end

  def existing_todos_can_be_seen
    all_items_available = @existing_todos.all? { |existing_todo|
      parsed_json['collection']['items'].find { |todo_representation|
        todo_representation['title'] == existing_todo.title
      }
    }

    all_items_available.should be_true
  end
end
