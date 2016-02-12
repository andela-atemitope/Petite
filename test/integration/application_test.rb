require_relative "../test_helper"
require "rack/test"
class TestIntegrationApp < Minitest::Test
  include Rack::Test::Methods
  instance_eval do
    def app=(val)
      @app = val
    end

    def app
      @app
    end
  end
  # self.count = 0

  def app
    self.class.app ||= Rack::Builder.parse_file(
      "#{__dir__}/Things_To_Do/config.ru").first
  end

  def test_root_path
    get "/"
    assert last_response.ok?
  end

  # def create_todo
  #   post "/todo",
  #     title: "This is a test post", body: "this is the body of the first test post"
  #   # self.class.count = self.class.count + 1
  # end

  #
  # def test_creating_new_todo
  #   Todo.delete_all
  #   create_todo
  #   assert_equal Todo.all.size, 1
  #   Todo.delete_all
  # end



  # def test_visiting_fellow_path
  #   Todo.delete_all
  #   create_todo
  #   get "/todo/1"
  #   # binding.pry
  #   assert last_response.ok?
  #   assert last_response.body.include? "This is a test post"
  #   assert last_response.body.include? "this is the body of the first test post"
  #   # Todo.delete_all
  # end
end
