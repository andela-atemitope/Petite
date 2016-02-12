$LOAD_PATH.unshift __dir__

require_relative 'config/application.rb'
ThingsApplication = ThingsToDo::Application.new
require_relative "config/routes.rb"
use Rack::Reloader, 0
use Rack::MethodOverride
run ThingsApplication


#define my resources method
#check for view rendering

#ORM
