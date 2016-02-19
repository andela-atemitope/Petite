require "petite/version"
require "petite/dependencies.rb"
require "petite/controller.rb"
require "petite/utilities.rb"
require "petite/route.rb"
require "petite/resources.rb"
require "petite/orm/orm.rb"
require "pry"

module Petite
  class Application
    attr_reader :request
    def call(env)
      @request = Rack::Request.new(env)
      if request.path_info == "/favicon.ico"
        return [404, {}, []]
      end
      page = get_rack_app(request)
      if page.nil?
        error_message
      else
        page
      end
    end

    def error_message
      [404, {}, ["ERROR 404! \n #{request.request_url}
      is not a defined route. \n
      Check your /config/routes.rb to view all defined
      routes"]]
    end

    def route
      @router ||= Petite::Router.new
    end

    def get_rack_app(request)
      @router.check_url(request)
    end
  end
end
