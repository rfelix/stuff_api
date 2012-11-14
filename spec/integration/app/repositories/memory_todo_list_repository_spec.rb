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

  describe '#find_by_id' do
    it 'finds the existing todo list by id' do
      todo_list1 = TodoList.new(title: 'Todo List 1')
      todo_list_repository = MemoryTodoListRepository.new(true)

      todo_list_repository.create todo_list1

      found_item = todo_list_repository.find_by_id(todo_list1.id)

      found_item.should_not be_nil
      found_item.title.should eq('Todo List 1')
    end
  end

  describe '#create' do
    it 'stores the todo list and gives it an identity' do
      todo_list1 = TodoList.new(title: 'Todo List 1')
      todo_list_repository = MemoryTodoListRepository.new(true)

      todo_list_repository.create todo_list1

      created_todo_list = todo_list_repository.list_all.first
      created_todo_list.should_not be_nil
      created_todo_list.id.should_not be_nil
    end

    it 'stores the todo list with any associated todos and gives each their own identity' do
      # This essentially acts like an aggregate object using the Domain Driven Design terminology
      todo = Todo.new(title: 'Todo 1')
      todo_list = TodoList.new(title: 'Todo List 1', todos: [todo])

      todo_list_repository = MemoryTodoListRepository.new(true)

      todo_list_repository.create todo_list

      created_todo_list = todo_list_repository.list_all.first

      created_todo_list.should_not be_nil
      all_todos_have_ids = created_todo_list.todos.all? { |todo| !todo.id.nil? }
      all_todos_have_ids.should be_true
    end
  end
end
