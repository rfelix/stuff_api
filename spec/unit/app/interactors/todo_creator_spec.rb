require 'spec_helper'

describe TodoCreator do
  describe '#create_todo' do
    it 'adds the Todo to the specified Todo List' do
      user = User.new
      todo_list = TodoList.new(id: 1, title: 'Inbox')
      todo_list_repository = stub('Todo List Repository', update: true)
      todo_creator = TodoCreator.new(todo_list_repository: todo_list_repository)

      todo_list_repository.stub find_by_id: todo_list

      todo_creator.create_todo(
        todo_list_id: 1,
        data: {'title' => 'Todo', 'notes' => 'Something', 'due_date' => '2012-11-15', 'completed' => 'true'},
        user: user
      )

      todo_list.todos.should have(1).item
      todo_list.todos.first.title.should eq('Todo')
      todo_list.todos.first.completed.should be_true
      todo_list.todos.first.notes.should eq('Something')
      todo_list.todos.first.due_date.should eq(Date.new(2012, 11, 15))
    end

    it 'stores the new todo in the corresponding Todo List repository' do
      user = User.new
      todo_list = TodoList.new(id: 1, title: 'Inbox')
      todo_list_repository = stub('Todo List Repository')
      todo_creator = TodoCreator.new(todo_list_repository: todo_list_repository)

      todo_list_repository.stub find_by_id: todo_list

      todo_list_repository.should_receive(:update).with(todo_list)

      todo_creator.create_todo(
        todo_list_id: 1,
        data: {'title' => 'Todo', 'notes' => 'Something', 'due_date' => '2012-11-15'},
        user: user
      )
    end
  end
end
