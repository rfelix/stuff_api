require 'acceptance_spec_helper'

describe 'When listing a Todo List' do
  Given(:todo_list_repository) { MemoryTodoListRepository.singleton }
  Given { existing_todos_in_inbox }

  When { inbox_todo_list_href_is_followed }

  Then { show_me_the_json }
  Then { collection_href.should eq(last_request.url) }
  Then { all_todos_should_be_listed }

  def existing_todos_in_inbox
    inbox_list = todo_list_repository.list_all.find { |todo_list| todo_list.title == 'Inbox' }
    @existing_todos = [Todo.new(title: 'Build Hypermedia API', notes: 'Test', due_date: Date.new(2012, 11, 15))]
    @existing_todos.each do |new_todo|
      inbox_list.add new_todo
    end
    todo_list_repository.update inbox_list
  end

  def inbox_todo_list_href_is_followed
    get '/'
    inbox_item = parsed_json['collection']['items'].find { |item| item['title'] == 'Inbox' }
    get inbox_item['href']
  end

  def all_todos_should_be_listed
    all_todos_available = @existing_todos.all? { |existing_todo|
      parsed_json['collection']['items'].find { |todo_representation|
        todo_representation['title'] == existing_todo.title &&
          representation_same_as_todo?(todo_representation, existing_todo)
      }
    }

    all_todos_available.should be_true
  end

  def representation_same_as_todo?(representation, todo)
    todo = TodoPresenter.new(todo)
    representation['title'].should eq(todo.title)
    representation['notes'].should eq(todo.notes)
    representation['dueDate'].should eq(todo.due_date)
  end
end
