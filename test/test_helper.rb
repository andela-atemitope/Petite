$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
$LOAD_PATH << File.join(File.dirname(__FILE__), '../../lib')


require './lib/petite/orm/orm.rb'
require './lib/petite/orm/orm_formatter.rb'
require './lib/petite/orm/orm_queries.rb'
require './lib/petite/orm/sql_connector.rb'
require 'petite'

require 'minitest/autorun'
