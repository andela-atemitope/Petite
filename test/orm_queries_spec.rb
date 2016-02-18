require "spec_helper"

describe "Petite Orm Queries"do

  it " deletes all rows in a table" do
    create_test_todo
    expect(Todo.delete_all).to eq []
  end

  it "returns the first item in the database" do
    create_test_todo
    expect(Todo.first).to include "Title for first todo"
  end

  it "returns the last item in the database" do
    create_third_test_todo
    expect(Todo.last).to include "Body for third Todo"
  end

  it "returns all item in the database" do
    create_test_todo
    create_second_test_todo
    # binding.pry
    expect(Todo.all).to include "Body for Second Todo"
  end

  it "deletes items from the database" do
    create_test_todo
    id = Todo.first.id
    expect(Todo.delete(id)).to eql []
  end

  # it "finds items from the database by id" do
  #   create_posts
  #   create_second_posts
  #   search_title = Todo.first.title
  #   expect(Todo.find_by(title, search_title)).to include "Body for first Todo"
  # end
end
