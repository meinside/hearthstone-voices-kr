require 'sqlite3'

SOUNDS_DIR = 'sounds'
SOUNDFILE_EXT = 'm4a'

DB_FILENAME = "hearthstone_voices_kr_#{Time.now.strftime("%Y-%m-%d")}.sqlite"
CSV_FILENAME = "hearthstone_voices_kr_#{Time.now.strftime("%Y-%m-%d")}.csv"

# play sound file
def play_sound(filepath)
  `afplay "#{filepath}"`
end

