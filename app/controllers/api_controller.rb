StuffServer.controller provides: :json do
  before do
    # Load the corresponding user based on their authentication
    @user = User.new
  end

  get :root, map: '/' do
    todo_list_lister = TodoListLister.new(todo_list_repository: MemoryTodoListRepository.new)

    render 'root', locals: {list_items: todo_list_lister.list_all(@user) }
  end
end
