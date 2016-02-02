require 'petite/version'
require 'petite/controller.rb'
require 'petite/dependencies.rb'
require 'petite/utilities.rb'
require 'petite/route.rb'
require 'petite/resources.rb'
require 'petite/orm.rb'
require 'pry'

module Petite
  class Application
    attr_reader :request
    def call(env)
      @request = Rack::Request.new(env)
      return [500, {}, []] if env['PATH_INFO'] == '/favicon.ico'
      get_rack_app(request)
    end

    def route
      @router ||= Petite::Router.new
    end

    def get_rack_app(request)
      @router.check_url(request)
    end
  end
end
