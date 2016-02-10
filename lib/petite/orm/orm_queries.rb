module Petite
  class PetiteRecord
    def self.select
      result = SqlConnector.execute "SELECT * FROM #{@table_name} WHERE id = ?", id
      format_output(result)
    end

    def self.select_all
      result = SqlConnector.execute "SELECT #{@property.keys.join(',')} FROM #{@table_name}"
      result.map { |row| format_output(row) }
    end

    def self.first
       SqlConnector.execute "SELECT * FROM #{table_name} ORDER BY #{table.id} ASC LIMIT 1"
    end

    def self.last
      SqlConnector.execute "SELECT * FROM #{table_name} ORDER BY #{table_name.id} DESC LIMIT 1"
    end

    def self.delete(id)
      SqlConnector.execute "DELETE FROM #{table_name} WHERE id = ?", id
    end

    def delete_all
      SqlConnector.execute "DELETE * FROM #{table_name}"
    end

    def self.find_by(parameter, value)
      SqlConnector.execute "SELECT * FROM #{table_name} WHERE(#{parameter}: #{value})"

    end

    def self.table_name
      @table_name
    end

    def method_missing(method, *args)
      self.send(method)
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
