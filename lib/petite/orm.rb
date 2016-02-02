module Petite
  class Orm
    class << self
        @@property = {}

       def to_table(tablename)
         @name =  tablename
       end

       def property(field, attr)
           @@property[field] = attr

       end


       def create_table
          property_array = []
          test_array = []
           @@property.each do |key, value|
               prop_array_two = []
               prop_array_two << key
              value.each do |button, shirt|
                  case button
                    when :primary_key
                        prop_array_two << "primary key"
                    when :autoincrement
                        prop_array_two << "autoincrement" if shirt
                    when :nullable
                        prop_array_two << "not null" unless shirt
                    else
                  end


                    case shirt
                        when :integer
                            prop_array_two << "INTEGER"
                        when :varchar
                            prop_array_two << "VARCHAR"
                        when :text
                            prop_array_two << "TEXT"
                        when :float
                            prop_array_two << "FLOAT"
                        else
                      end
              end
            property_array << prop_array_two.join(" ")
           end
        p "CREATE TABLE #{@name}, #{property_array.join(', ')}"

        # "CREATE TABLE name (user_id INTEGER primary key autoincrement, email VARCHAR not null, address VARCHAR not null, name VARCHAR)"
       end
    end
  end
end

class SampleModel < Temi
    to_table(:users)
    property(:user_id, type: :integer, primary_key: true, autoincrement: true)
    property(:email, type: :text, nullable: false)
    property(:tags, type: :text, nullable: false)
    property(:location, type: :float, nullable: true)
    property(:name, type: :varchar)
    create_table
end

SampleModel