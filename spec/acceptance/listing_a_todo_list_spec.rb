require 'acceptance_spec_helper'

describe 'When listing a Todo List' do
  Given(:todo_list_repository) { StuffServer.in_memory_todo_list_repository}
  Given { existing_todos_in_inbox }

  When { api_root_is_visited and item_href_is_visited('title' => 'Inbox') }

  Then { parsed_collection.href.should eq(last_request.url) }
  Then { all_todos_should_be_listed }

  def all_todos_should_be_listed
    all_todos_available = @existing_todos.all? { |existing_todo|
      parsed_collection.items.find { |todo_item|
        todo_item.data['title'].value == existing_todo.title && representation_same_as_todo?(todo_item, existing_todo)
      }
    }

    all_todos_available.should be_true
  end

  def representation_same_as_todo?(todo_item, todo_entity)
    todo = TodoPresenter.new(todo_entity)
    todo_item.data['title'].value.should eq(todo.title)
    todo_item.data['notes'].value.should eq(todo.notes)
    todo_item.data['dueDate'].value.should eq(todo.due_date)
  end
end
