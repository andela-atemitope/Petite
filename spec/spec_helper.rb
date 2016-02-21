$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)


require "petite"
require "codeclimate-test-reporter"
require "simplecov"
SimpleCov.start
# require 'coveralls'
# Coveralls.wear!
CodeClimate::TestReporter.start


class Todo < Petite::PetiteRecord
  to_table :todo
  property :id, type: :integer, primary_key: true
  property :title, type: :text, nullable: false
  property :body, type: :text, nullable: false
  property :created_at, type: :text, nullable: false
  create_table
end

def create_test_todo
  @todo = Todo.new
  @todo.title = "Title for first todo"
  @todo.body = "Body for first todo"
  @todo.created_at = Time.now.to_s
  @todo.save
end

def create_second_test_todo
  @todo = Todo.new
  @todo.title = "Title for second todo"
  @todo.body = "Body for Second Todo"
  @todo.created_at = Time.now.to_s
  @todo.save
end

def create_third_test_todo
  @todo = Todo.new
  @todo.title = "Title for third todo"
  @todo.body = "Body for third Todo"
  @todo.created_at = Time.now.to_s
  @todo.save
end
