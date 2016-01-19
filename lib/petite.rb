require "petite/version"

module Petite
  class Application
    def call
      [ 200, {"Content-Type" => "text/html" }, [ "Hello" ]]
    end
  end
end
