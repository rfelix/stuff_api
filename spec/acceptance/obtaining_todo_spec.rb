require 'acceptance_spec_helper'

describe 'When obtaining a Todo' do
  Given(:todo_list_repository) { StuffServer.in_memory_todo_list_repository}
  Given { existing_todos_in_inbox }
  When { todo_item_from_inbox_is_visited }
  Then { representation_should_match_todo }

  def todo_item_from_inbox_is_visited
    api_root_is_visited
    item_href_is_visited 'title' => 'Inbox'
    item_href_is_visited 'title' => @existing_todos.first.title
  end

  def representation_should_match_todo
    todo_item = parsed_collection.items.first
    todo_item.should_not be_nil

    existing_todo = @existing_todos.find { |todo| todo.title == todo_item.data['title'].value }

    representation_same_as_todo?(todo_item, existing_todo).should be_true
  end

  # TODO Remove duplication
  def representation_same_as_todo?(todo_item, todo_entity)
    todo = TodoPresenter.new(todo_entity, nil)
    todo_item.data['title'].value.should eq(todo.title)
    todo_item.data['notes'].value.should eq(todo.notes)
    todo_item.data['dueDate'].value.should eq(todo.due_date)
  end
end
