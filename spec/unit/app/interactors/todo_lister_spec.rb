require 'spec_helper'

describe TodoLister do
  describe '#list_all' do
    it 'lists all the Todos associated to corresponding Todo List' do
      user = User.new
      todo = Todo.new(title: 'Build a Hypermedia API')
      todo_list = TodoList.new(title: 'Inbox', todos: [todo])
      todo_list_repository = stub('Todo List Repository')
      todo_lister = TodoLister.new(todo_list_repository: todo_list_repository)

      todo_list_repository.stub find_by_id: todo_list

      all_todos = todo_lister.list_all(user, 1)

      all_todos.first.title.should == 'Build a Hypermedia API'
    end
  end

  describe '#list_one' do
    it 'retreives the specified Todo item from the specified Todo list' do
      user = User.new
      todo = Todo.new(id: 1, title: 'Build a Hypermedia API')
      todo_list = TodoList.new(id: 2, title: 'Inbox', todos: [todo])
      todo_list_repository = stub('Todo List Repository')
      todo_lister = TodoLister.new(todo_list_repository: todo_list_repository)

      todo_list_repository.stub find_by_id: todo_list

      found_todo = todo_lister.list_one(user, 2, 1)

      found_todo.id.should == 1
      found_todo.title.should == 'Build a Hypermedia API'
    end
  end
end
