require 'acceptance_spec_helper'

describe 'When creating a todo' do
  Given(:todo_list_repository) { StuffServer.in_memory_todo_list_repository}
  When { post_with_todo_sent_to 'Inbox' }
  Then { inbox_has_a_new_todo_item }
  Then { redirects_to_new_todo_location }

  def post_with_todo_sent_to(todo_list_title)
    api_root_is_visited
    item_href_is_visited('title' => 'Inbox')

    todo = Todo.new(title: 'A completely new todo')
    @existing_todos = [todo]

    data = parsed_collection.build_template('title' => todo.title, 'dueDate' => '2012-11-15')
    post parsed_collection.href, data.to_json
  end

  def inbox_has_a_new_todo_item
    todo_list = todo_list_repository.list_all.find { |todo_list| todo_list.title == 'Inbox' }
    found_new_todo = todo_list.todos.find { |todo| todo.title == @existing_todos.first.title }
    found_new_todo.should be_true
  end

end
