require 'acceptance_spec_helper'

describe 'When moving a Todo' do
  context 'initiating a move for a todo' do
    Given(:todo_list_repository) { StuffServer.in_memory_todo_list_repository}
    Given { existing_todos_in_inbox }

    When { move_initiated_for_one_of_the_todos_in_inbox }

    Then { available_list_destinations.should include('Today') }
    Then { available_list_destinations.should include('Next') }
    Then { available_list_destinations.should_not include('Inbox') }
  end

  def move_initiated_for_one_of_the_todos_in_inbox
    api_root_is_visited
    item_href_is_visited('title' => 'Inbox')
    item_link_is_visited('move', 'title' => @existing_todos.first.title)
  end

  def available_list_destinations
    parsed_collection.items.map { |item| item.data['title'].value }
  end
end
