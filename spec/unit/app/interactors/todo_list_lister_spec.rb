require 'spec_helper'

describe TodoListLister do
  describe '#list_all' do
    %w(Inbox Today Next).each do |list_title|
      it "includes the #{list_title} list" do
        user = User.new
        todo_list_repository = stub('Todo List Repository')
        todo_list_lister = TodoListLister.new(todo_list_repository: todo_list_repository)

        todo_list_repository.stub list_all: default_user_lists

        all_lists = todo_list_lister.list_all(user)

        all_lists.any? { |list| list.title == list_title }.should be_true
      end
    end
  end

  describe '#list_move_destinations' do
    it 'lists all the available todo lists except for the one the todo is already in' do
      user = User.new
      todo_id = 2
      todo_list_id = default_user_lists.first.id
      todo_list_repository = stub('Todo List Repository')
      todo_list_lister = TodoListLister.new(todo_list_repository: todo_list_repository)

      todo_list_repository.stub list_all: default_user_lists

      move_destinations = todo_list_lister.list_move_destinations(user, todo_list_id, todo_id)
      destination_titles = move_destinations.map { |todo_list| todo_list.title }

      destination_titles.should_not include(default_user_lists.first.title)
      default_user_lists[1..-1].each do |todo_list|
        destination_titles.should include(todo_list.title)
      end
    end
  end

  def default_user_lists
    id_counter = 0
    %w(Inbox Today Next).map { |title| TodoList.new id: (id_counter += 1), title: title }
  end
end
