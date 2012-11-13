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

  def default_user_lists
    %w(Inbox Today Next).map { |title| TodoList.new title: title }
  end
end
