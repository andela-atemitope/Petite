require "petite"

$LOAD_PATH.unshift File.expand_path("../../app/controllers", __FILE__)
$LOAD_PATH.unshift File.expand_path("../../app/models", __FILE__)

module ThingsToDo
  class Application < Petite::Application
  end
end
