require "petite/version"
require "petite/controller.rb"
require "petite/dependencies.rb"
require "petite/utilities.rb"


module Petite
  class Application
    def call(env)
      if env["PATH_INFO"] == "/"
        return [ 302, { "Location" => "/todo/index"}, []]
      end

      if env["PATH_INFO"] == "/favicon.ico"
        return [ 500, {}, [] ]
      end

      controller_class, action = get_controller_and_action(env)
      controller = controller_class.new(env)
      response = controller.send(action)
    end

    def get_controller_and_action(env)
      _, controller_name, action = env["PATH_INFO"].split("/")

      controller_name =  controller_name.to_camel_case + "Controller"
      [ Object.const_get(controller_name), action ]
    end
  end
end
