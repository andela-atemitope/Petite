class TodoController < Petite::Controller
  def index
    @todo = Todo.select_all
  end

  def new

  end

  def create
    todo_params = params
    @todo = Todo.new
    @todo.title = todo_params["title"]
    @todo.body = todo_params["body"]
    @todo.created_at = Time.now.to_s
    @todo.save
    redirect_to "/"
  end

  def edit
    @todo = Todo.find(params["id"])
  end

  def show
    @todo = Todo.find(params["id"])
  end

  def update
    @todo = Todo.find(params["id"])
    @todo.title = params["title"]
    @todo.body = params["body"]
    @todo.save
    redirect_to "/"
  end

  def destroy
    Todo.delete(params["id"])
    redirect_to "/"
  end

end
