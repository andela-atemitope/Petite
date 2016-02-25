require "tilt"

module Petite
  class Controller
    attr_reader :request, :response

    def initialize(request)
      @request ||= request
    end

    def params
      request.params
    end

    def response(body, status = 200, header = {})
      @response = Rack::Response.new(body, status, header)
    end

    def redirect_to(route)
      @response = Rack::Response.new({}, 302, "location" => route)
    end

    def get_response
      @response
    end

    def render(*args)
      response(render_template(*args))
    end

    def render_template(view_name, locals = {})
      layout_template = Tilt::ERBTemplate.new(File.join($LOAD_PATH.first,
                                                        "app", "views",
                                                        "layouts",
                                                        "application.html.erb"))
      template_title = view_name.to_s.tr("_", " ").capitalize
      view_template = Tilt::ERBTemplate.new(File.join($LOAD_PATH.first,
                                                      "app", "views",
                                                      controller_name,
                                                      "#{view_name}.html.erb"))
      layout_template.render(self, title: template_title) do
        view_template.render(self, locals.merge!(access_variables))
      end
    end

    def access_variables
      variables = {}
      instance_variables.each do |var|
        key = var.to_s.delete("@").to_sym
        variables[key] = instance_variable_get(var)
      end
      variables
    end

    def controller_name
      self.class.to_s.gsub(/Controller$/, "").to_snake_case
    end

    def dispatch(action)
      send(action)
      render(action) unless get_response
      get_response
    end

    def self.action(request, action_name)
      new(request).dispatch(action_name)
    end
  end
end
