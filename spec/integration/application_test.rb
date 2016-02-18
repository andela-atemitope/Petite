require_relative "../test_helper"
require "rack/test"
class TestIntegrationApp < Minitest::Test
  include Rack::Test::Methods
  instance_eval do
    def app=(val)
      @app = val
    end

    def count=(count)
      @count = count
    end

    def count
      @count
    end

    def app
      @app
    end
  end

  def app
    self.class.app ||= Rack::Builder.parse_file(
      "#{__dir__}/Things_To_Do/config.ru").first
  end

  def test_root_path
    get "/"
    assert last_response.ok?
  end

  def create_todo
    self.class.count ||= 0
    post "/todo",
         title: "This is a test post",
         body: "this is the body of the first test post"
    self.class.count = self.class.count + 1
  end

  def test_creating_new_todo
    Todo.delete_all
    create_todo
    assert_equal Todo.select_all.size, 1
    Todo.delete_all
  end
end
