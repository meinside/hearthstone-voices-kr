#!/usr/bin/env ruby

require 'csv'

require_relative './common.rb'

if __FILE__ == $0

  db = SQLite3::Database.new DB_FILENAME

  CSV.open(CSV_FILENAME, 'wb'){|csv|
    csv << ['id', 'filename', 'expansion', 'cardname', 'txt']

    db.execute("select id, filename, expansion, cardname, txt from voices order by id asc").each{|row|
      csv << row
    }
  }

end
