require 'spec_helper'

describe TodoMover do
  describe '#move_todo' do
    it 'moves a todo from one list to another' do
      user = User.new
      todo = Todo.new(id: 3, title: 'Build a Hypermedia API')
      current_todo_list = TodoList.new(id: 1, title: 'Inbox', todos: [todo])
      destination_todo_list = TodoList.new(id: 2, title: 'Today')
      todo_list_repository = setup_todo_list_repository_stub(current_todo_list, destination_todo_list)
      todo_mover = TodoMover.new(todo_list_repository: todo_list_repository)

      todo_mover.move_todo(user: user, current_todo_list_id: 1, destination_todo_list_id: 2, todo_id: 3)

      current_todo_list.todos.should be_empty
      destination_todo_list.todos.should have(1).item
    end

    it 'updates the todo lists within the repository' do
      user = User.new
      todo = Todo.new(id: 3, title: 'Build a Hypermedia API')
      current_todo_list = TodoList.new(id: 1, title: 'Inbox', todos: [todo])
      destination_todo_list = TodoList.new(id: 2, title: 'Today')
      todo_list_repository = setup_todo_list_repository_stub(current_todo_list, destination_todo_list)
      todo_mover = TodoMover.new(todo_list_repository: todo_list_repository)

      todo_list_repository.should_receive(:update).with(current_todo_list)
      todo_list_repository.should_receive(:update).with(destination_todo_list)

      todo_mover.move_todo(user: user, current_todo_list_id: 1, destination_todo_list_id: 2, todo_id: 3)
    end
  end

  def setup_todo_list_repository_stub(current_todo_list, destination_todo_list)
    repo = stub('Todo List Repository', update: true)

    repo.stub :find_by_id do |id|
      case id
      when current_todo_list.id
        current_todo_list
      when destination_todo_list.id
        destination_todo_list
      end
    end

    repo
  end
end
