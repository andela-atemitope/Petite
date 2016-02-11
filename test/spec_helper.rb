require './lib/petite/orm/orm.rb'
require './lib/petite/orm/orm_formatter.rb'
require './lib/petite/orm/orm_queries.rb'
require './lib/petite/orm/sql_connector.rb'
require 'petite'

class Todo < Petite::PetiteRecord
  to_table :todo
  property :id, type: :integer, primary_key: true
  property :title, type: :text, nullable: false
  property :body, type: :text, nullable: false
  property :done, type: :boolean, nullable: false
  property :created_at, type: :text, nullable: false
  create_table
end

def create_test_todo
  @todo = Todo.new
  @todo.title = "Title for first todo"
  @todo.body = "Body for first todo"
  @todo.done = false
  @todo.created_at = Time.now.to_s
  @todo.save
end

def create_second_test_todo
  @todo = Todo.new
  @todo.title = "Title for second todo"
  @todo.body = "Body for Second Todo"
  @todo.done = false
  @todo.created_at = Time.now.to_s
  @todo.save
end

def create_third_test_todo
  @todo = Todo.new
  @todo.title = "Title for third todo"
  @todo.body = "Body for third Todo"
  @todo.done = false
  @todo.created_at = Time.now.to_s
  @todo.save
end
