require "petite/version"
require "petite/controller.rb"
require "petite/dependencies.rb"
require "petite/utilities.rb"
require "petite/route.rb"
require "pry"


module Petite
  class Application
    attr_reader :request
    def call(env)
      @request = Rack::Request.new(env)
      if env["PATH_INFO"] == "/favicon.ico"
        return [ 500, {}, [] ]
      end
      # require "pry"; binding.pry
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
