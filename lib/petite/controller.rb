require "tilt"
require "erb"

module Petite
  class Controller
    attr_reader :request

    def initialize(env)
      @request ||= Rack::Request.new(env)
    end

    def params
      request.params
    end

    def response( body, status = 200, header = {} )
      @response = Rack::Response.new(body, status, header)
    end

    def get_response
      @response
    end

    def render(*args)
      response(render_template(*args))
    end

    def render_template(view_name, locals = {})
      view_file = Tilt.new(File.join("app", "views", controller_name, "#{view_name}.erb"))
      template = File.read(view_file)

      variables = {}
      instance_variables.each do |var|
        key = var.to_s.gsub("@", "").to_sym
        variables[key] = instance_variable_get(var)
      end

      Tilt::ERBTemplate.new(filename).render(self, locals.merge(variables))
    end

    def controller_name
      self.class.to_s.gsub(/Controller$/, "").to_snake_case
    end

    def dispatch(action)
      content = self.send(action)
      if get_response
        get_response
      else
        render(action)
        get_response
      end
    end

    def self.action(action_name)
      -> (env) { self.new(env).dispatch(action_name) }
    end
  end
end