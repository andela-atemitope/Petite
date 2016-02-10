require 'petite/orm/orm_queries.rb'
require 'petite/orm/sql_connector.rb'
require 'petite/orm/orm_formatter.rb'
require 'sqlite3'

module Petite
  class PetiteRecord
     def self.to_table(tablename)
       @table_name =  tablename
     end

     def self.property(field, attr)
      @property ||= {}
      @property[field] = attr
     end

     def self.create_table
        property_array = []
         @property.each do |key, value|
            prop_array_two ||= []
            prop_array_two << key
            value.each do |name, text|
              prop_array_two << send("fetch_#{name.downcase}", text)
            end
          property_array << prop_array_two.join(" ")
         end
       query = "CREATE TABLE IF NOT EXISTS #{@table_name} (#{property_array.join(',')})"
       SqlConnector.execute query
       make_method
     end

     def self.make_method
       methods = @property.keys.map(&:to_sym)
       methods.each { |method| attr_accessor method }
     end

     def self.fetch_primary_key(value = false)
       "primary key" if value
     end

     def self.fetch_autoincrement(value = false)
       "autoincrement" if value
     end

    def self.fetch_nullable(value = true)
      "not null" unless value
    end

    def self.fetch_type(value)
      value.to_s
    end
  end
end
