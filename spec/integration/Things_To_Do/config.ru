# $LOAD_PATH.unshift __dir__

# $LOAD_PATH.unshift(File.join(__dir__,"app", "models"));
# $LOAD_PATH.unshift(File.join(__dir__,"app", "controllers"));
require_relative "config/application.rb"
$LOAD_PATH.unshift __dir__
ThingsApplication = ThingsToDo::Application.new
require_relative "config/routes.rb"
use Rack::Reloader, 0
use Rack::MethodOverride
run ThingsApplication

# define my resources method
# check for view rendering

# ORM
