#!/usr/bin/env ruby
require 'sqlite3'
require 'yaml'

@db = SQLite3::Database.new "/home/ch/music/tmp/pacemaker/music.db"
def sql sql
  @db.execute sql
end
#puts sql("SELECT * FROM sqlite_master WHERE type='table'").to_yaml#.collect{|t| t[1]}.inspect
cases = sql "select case_id,name from cases"
cases.each do |c|
  case_id = c[0]
  case_name = c[1]
  playlist_file = File.join("/home/ch/music/playlists",case_name+".m3u")
  File.open(playlist_file,"w+"){|f| f.puts "#EXTM3U"} unless File.exists? playlist_file
  File.open(playlist_file,"a+") do |playlist| 
    track_ids = sql "select track_id from casetracks where case_id=#{case_id}"
    track_ids.each do |track_id|
      tracks = sql "select artist,title,format,bpm from tracks where track_id=#{track_id[0]}"
      track = sql("select title from tracks where track_id=#{track_id[0]}")[0][0]
      files = Dir["/home/ch/music/soundcloud/**/#{track}*"]
      puts "More than one file for #{track}: #{files.inspect}" unless files.size == 1  
      playlist.puts files[0]
    end
  end
end
