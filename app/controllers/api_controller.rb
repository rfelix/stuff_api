StuffServer.controller provides: :json do
  before do
    # Load the corresponding user based on their authentication
    @user = User.new
  end

  get :root, map: '/' do
    todo_list_lister = TodoListLister.new(todo_list_repository: todo_list_repository)
    todo_lists = todo_list_lister.list_all(@user)

    render 'collection', locals: {list_items: todo_lists}
  end

  get :todo_list, map: '/list/:id' do
    todo_lister = TodoLister.new(todo_list_repository: todo_list_repository)
    todo_list_id = params[:id].to_i
    todo_items = todo_lister.list_all(@user, todo_list_id)

    render 'list/collection', locals: {todo_list_collection: TodoListCollectionPresenter.new(todo_list_id, todo_items)}
  end

  get :todo_item, map: '/list/:list_id/todo/:id' do
    todo_lister = TodoLister.new(todo_list_repository: todo_list_repository)
    todo_list_id = params[:list_id].to_i
    todo_id = params[:id].to_i
    todo_item = todo_lister.list_one(@user, todo_list_id, todo_id)

    render 'todo/individual', locals: {todo_item: TodoPresenter.new(todo_item, todo_list_id)}
  end

  helpers do
    def todo_list_repository
      StuffServer.in_memory_todo_list_repository
    end
  end
end
