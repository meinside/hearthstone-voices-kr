#!/usr/bin/env ruby

require 'sqlite3'

require_relative './common.rb'

def escape(str)
  return "" if str.nil?

  str.gsub(/[\?\!\.,:\/"']/, "")  # remove special characters
end

def get_filepath(expansion, cardname, txt)
  cardname = escape(cardname)
  txt = escape(txt)

  filepath = File.join(OUTPUT_DIR, "#{["Hearthstone", expansion, cardname, txt].compact.reject{|x|x.empty?}.join(" - ")}.#{SOUNDFILE_EXT}")

  get_safe_filepath(filepath)
end

def get_safe_filepath(filepath)
  loop do
    if File.exists? filepath
      filename = File.basename(filepath, ".*")
      filepath = filepath.gsub(filename, "#{filename}_")
    else
      break
    end
  end

  return filepath
end

if __FILE__ == $0

  OUTPUT_DIR = "#{SOUNDS_DIR}_renamed"

  `rm -rf "#{OUTPUT_DIR}"`
  `mkdir "#{OUTPUT_DIR}"`

  db = SQLite3::Database.new DB_FILENAME
  db.execute("select id, filename, expansion, cardname, txt from voices order by id asc").each{|row|
    filename, expansion, cardname, txt = row[1], row[2], row[3], row[4]

    filepath = File.join(SOUNDS_DIR, "#{filename}.#{SOUNDFILE_EXT}")
    renamed = get_filepath(expansion, cardname, txt)

    `cp "#{filepath}" "#{renamed}"`
  }

end
