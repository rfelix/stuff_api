require 'acceptance_spec_helper'

describe 'When moving a Todo' do
  Given(:todo_list_repository) { StuffServer.in_memory_todo_list_repository}
  Given { existing_todos_in_inbox }

  context 'initiating a move for a todo' do
    When { move_initiated_for_one_of_the_todos_in_inbox }

    Then { available_list_destinations.should include('Today') }
    Then { available_list_destinations.should include('Next') }
    Then { available_list_destinations.should_not include('Inbox') }
  end

  context 'PUTing the move template' do
    When { move_initiated_for_one_of_the_todos_in_inbox and todo_is_moved_to 'Today' }

    Then { redirects_to_new_todo_location }
    Then { todos_in_list('Inbox').should_not include(@existing_todos.first.title) }
    Then { todos_in_list('Today').should include(@existing_todos.first.title) }
  end

  def move_initiated_for_one_of_the_todos_in_inbox
    api_root_is_visited
    item_href_is_visited('title' => 'Inbox')
    item_link_is_visited('move', 'title' => @existing_todos.first.title)
  end

  def todo_is_moved_to(destination_todo_list_title)
    destination = parsed_collection.items.find { |item| item.data['title'].value == destination_todo_list_title }
    destination.should_not be_nil

    data = parsed_collection.build_template('destination_uri' => destination.href)
    put parsed_collection.href, data.to_json
  end

  def available_list_destinations
    parsed_collection.items.map { |item| item.data['title'].value }
  end

  def todos_in_list(list_title)
    todo_list = todo_list_repository.list_all.find { |todo_list| todo_list.title == list_title }
    todo_list.should_not be_nil
    todo_list.todos.map(&:title)
  end
end
