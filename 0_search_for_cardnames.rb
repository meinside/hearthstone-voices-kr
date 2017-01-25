#!/usr/bin/env ruby

require_relative './common.rb'

if __FILE__ == $0

  STDOUT.sync = true

  db = SQLite3::Database.new DB_FILENAME

  # select all unknown cards
  db.execute("select id, filename, expansion, cardname, txt from voices where cardname is null or cardname = '' order by id").each{|row|
    id, filename, expansion, txt = row[0], row[1], row[2], row[4]

    if ['공통', '선술집 난투', '튜토리얼'].include?(expansion)
      expansion = ''
    end

    query = "하스스톤#{expansion.empty? ? "" : "+#{expansion.gsub(' ', '+')}" }+#{txt.gsub(' ', '+')}+site:namu.wiki"
    puts "> [#{expansion}] search query: #{query}"

    file = File.join(SOUNDS_DIR, "#{filename}.#{SOUNDFILE_EXT}")

    play_sound file

    print "> Input cardname: "
    cardname = STDIN.gets.chomp
    if cardname.length > 0
      db.execute('update voices set cardname = ? where id = ?', [cardname, id])
    end
  }

end
