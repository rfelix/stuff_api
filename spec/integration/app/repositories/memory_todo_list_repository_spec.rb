require 'spec_helper'

describe MemoryTodoListRepository do
  describe '#list_all' do
    it 'returns all the existing todo lists' do
      todo_list1 = TodoList.new(title: 'Todo List 1')
      todo_list2 = TodoList.new(title: 'Todo List 2')
      todo_list_repository = MemoryTodoListRepository.new(true)

      todo_list_repository.create todo_list1
      todo_list_repository.create todo_list2

      todo_lists = todo_list_repository.list_all

      todo_lists.should have(2).items
      todo_lists.first.title.should eq('Todo List 1')
      todo_lists.last.title.should eq('Todo List 2')
    end
  end
end