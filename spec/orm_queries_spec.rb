require "spec_helper"

describe "Petite Orm Queries" do
  it " deletes all rows in a table" do
    create_test_todo
    expect(Todo.delete_all).to eq []
  end

  it "returns the first item in the database" do
    create_test_todo
    result = Todo.all
    expect(result.first.title).to eql "Title for first todo"
  end

  it "returns the last item in the database" do
    create_third_test_todo
    Todo.last
    expect(Todo.last).to include "Body for third Todo"
  end

  it "returns all items in the database" do
    create_test_todo
    create_second_test_todo
    expect(Todo.all.last.body).to eql "Body for Second Todo"
    expect(Todo.all.first.body).to eql "Body for first todo"
  end

  it "deletes items from the database" do
    create_test_todo
    id = Todo.first.id
    expect(Todo.delete(id)).to eql []
  end
end
