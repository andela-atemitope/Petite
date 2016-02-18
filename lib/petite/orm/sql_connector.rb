module Petite
  class SqlConnector
    attr_reader :db
    def self.create_db
      @db = SQLite3::Database.new File.join "petite.db"
    end

    def self.execute(query, args = nil)
      @db ||= create_db
      return @db.execute(query, args) if args
      @db.execute(query)
    end
  end
end
