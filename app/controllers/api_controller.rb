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

  get :move_todo, map: '/list/:list_id/todo/:id/move' do
    todo_list_lister = TodoListLister.new(todo_list_repository: todo_list_repository)
    todo_list_id = params[:list_id].to_i
    todo_id = params[:id].to_i
    todo_lists = todo_list_lister.list_move_destinations(@user, todo_list_id, todo_id)

    render 'move_collection', locals: {move_todo_lists: TodoMoveListPresenter.new(todo_lists, todo_list_id, todo_id) }
  end

  put :move_todo, map: '/list/:list_id/todo/:id/move' do
    json = JSON.parse(request.body.read)
    todo_mover = TodoMover.new(todo_list_repository: todo_list_repository)
    todo_list_id = params[:list_id].to_i
    todo_id = params[:id].to_i
    destination_uri = json['template']['data'].find { |data| data['name'] == 'destination_uri' }
    destination_list_id = destination_uri['value'].split('/')[-1].to_i

    todo_mover.move_todo(
      user: @user,
      current_todo_list_id: todo_list_id,
      todo_id: todo_id,
      destination_todo_list_id: destination_list_id
    )

    redirect url_for(:todo_item, list_id: destination_list_id, id: todo_id)
  end

  helpers do
    def todo_list_repository
      StuffServer.in_memory_todo_list_repository
    end
  end
end
