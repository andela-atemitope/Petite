require "petite"

$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "app", "controllers")
$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "app", "model")

module ThingsToDo
  class Application < Petite::Application
  end
end
