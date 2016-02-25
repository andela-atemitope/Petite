module Petite
  class PetiteRecord
    def self.find(id)
      data = SqlConnector.execute("SELECT #{property_keys.join(',')}
      FROM #{@table_name} WHERE id = ?", id.to_s).first
      if data
        format_output(data)
      else
        raise "This Id is Unavailable"
      end
    end

    def self.all
      result = SqlConnector.execute "SELECT #{property_keys.join(',')}
      FROM #{@table_name}"
      result.map { |row| format_output(row) }
    end

    def self.first
      data = SqlConnector.execute "SELECT * FROM #{@table_name}
      ORDER BY id LIMIT 1"
      format_output(data[0])
    end

    def self.last
      result = SqlConnector.execute "SELECT * FROM #{@table_name}
      ORDER BY id DESC LIMIT 1"
      result.first
    end

    def self.delete(id)
      SqlConnector.execute "DELETE FROM #{@table_name}
      WHERE id = #{id}"
    end

    def self.delete_all
      SqlConnector.execute "DELETE FROM #{@table_name}"
    end

    def self.find_by(parameter, value)
      SqlConnector.execute "SELECT * FROM #{@table_name}
      WHERE(#{parameter} = #{value})"
    end

    class << self
      attr_reader :table_name
    end

    def method_missing(method, *_args)
      send(method)
    end

    def save
      table_name = self.class.table_name
      if id
        SqlConnector.execute "UPDATE #{table_name} SET
        #{update_records_placeholders} WHERE id = ?", update_table_records
      else
        SqlConnector.execute "INSERT INTO #{table_name} (#{get_table_columns})
        VALUES  (#{new_record_placeholders})", new_record_value
      end
    end
  end
end
