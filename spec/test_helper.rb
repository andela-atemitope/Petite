$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)




# require './lib/petite/orm/orm.rb'
# require './lib/petite/orm/orm_formatter.rb'
# require './lib/petite/orm/orm_queries.rb'
# require './lib/petite/orm/sql_connector.rb'
require "petite"
# require "codeclimate-test-reporter"
require "simplecov"
SimpleCov.start
# CodeClimate::TestReporter.start
require "simplecov"
require "minitest/spec"
require "minitest/autorun"
require "minitest/unit"


class MyTest < Minitest::Unit
  after_tests do
    FileUtils.rm_rf "petite.db"
  end
end
