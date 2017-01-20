#!/usr/bin/env ruby

require 'csv'
require 'sqlite3'

require_relative './common.rb'

if __FILE__ == $0

  `rm -f "#{DB_FILENAME}"`

  db = SQLite3::Database.new DB_FILENAME
  db.execute("create table if not exists voices(
    id integer primary key autoincrement,
    filename text not null,
    expansion text,
    cardname text,
    txt text default null)"
  )

  CSV.read(CSV_FILENAME)[1..-1].each{|row|  # XXX - skip header
    id = row[0]
    filename = row[1]
    expansion = row[2]
    cardname = row[3]
    txt = row[4]

    db.execute("insert into voices(id, filename, expansion, cardname, txt) values(?, ?, ?, ?, ?)", [id, filename, expansion, cardname, txt])
  }

end
