module Petite
  class PetiteRecord
    def get_values
      attributes = self.class.property_keys
      attributes.delete(:id)
      attributes.map { |method| send(method) }
    end

    def update_records_placeholders
      columns = self.class.property_keys
      columns.delete(:id)
      columns.map { |col| "#{col}=?" }.join(",")
    end

    def get_table_columns
      columns = self.class.property_keys
      columns.delete(:id)
      columns.join(",")
    end

    def update_table_records
      get_values << send(:id)
    end

    def new_record_value
      get_values
    end

    def self.property_keys
      @property.keys
    end

    def new_record_placeholders
      properties = self.class.property_keys
      (["?"] * (properties.size - 1)).join(",")
    end

    def self.format_output(row)
      model_name = new
      @property.each_key.with_index do |value, index|
        model_name.send("#{value}=", row[index])
      end
      model_name
    end
  end
end
