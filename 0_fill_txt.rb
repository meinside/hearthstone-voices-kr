#!/usr/bin/env ruby

require_relative './common.rb'

if __FILE__ == $0

  STDOUT.sync = true

  db = SQLite3::Database.new DB_FILENAME
  db.execute("create table if not exists voices(
    id integer primary key autoincrement,
    filename text not null,
    expansion text,
    cardname text,
    txt text default null)"
  )

  # play all sound files
  Dir[File.join(SOUNDS_DIR, "*.#{SOUNDFILE_EXT}")].each{|file|
    filename = File.basename(file, ".#{SOUNDFILE_EXT}")

    unless db.execute('select count(id) from voices where filename = ?', filename)[0][0] > 0
      case 
      when filename =~ /^VO_CS2_/i || filename =~ /^VO_EX1_/i || filename =~ /^VO_NEW1_/i  # original
        expansion = "오리지널"
      when filename =~ /^VO_FP1_/i  # 낙스라마스의 저주
        expansion = "낙스라마스의 저주"
      when filename =~ /^VO_GVG_/i  # 고블린대노움
        expansion = "고블린 대 노움"
      when filename =~ /^VO_BRM/i # 검은바위 산
        expansion = "검은바위 산"
      when filename =~ /^VO_AT_/i # 대 마상시합
        expansion = "대 마상시합"
      when filename =~ /^VO_LOE_/i # 탐험가 연맹
        expansion = "탐험가 연맹"
      when filename =~ /^VO_OG_/i # 고대 신의 속삭임
        expansion = "고대 신의 속삭임"
      when filename =~ /^VO_KARA_/i # 한여름 밤의 카라잔
        expansion = "한여름 밤의 카라잔"
      when filename =~ /^VO_CFM_/i # 비열한 거리의 가젯잔
        expansion = "비열한 거리의 가젯잔"
      else
        expansion = ""
      end

      puts "> Playing: #{file} (#{expansion})"

      Signal.trap('INT') {  # ctrl-c to quit
        exit 0
      }
      Signal.trap('QUIT') {  # ctrl-\ to next sound
        next
      }

      play_sound file

      print "> Input text: "
      txt = STDIN.gets.chomp
      if txt.length > 0
        db.execute('insert into voices(filename, expansion, txt) values (?, ?, ?)', [filename, expansion, txt])
      end
    end
  }

end
