#!/usr/bin/env ruby

tag = ARGV[0]
files = []

def read tag
  File.read(File.join("/media/mmc1","playlists","#{tag}.m3u")).split("\n").select{|l| l.match(/^[\/a-zA-Z]/)}
rescue
  Array.new
end

def write tag, files
  File.open(File.join("/media/mmc1","playlists","#{tag}.m3u"),"w+") do |f|
    f.puts "#EXTM3U"
    f.puts files.compact.uniq.join("\n")
  end
end

File.open("/tmp/mplayer-input","w+"){|f| f.puts "get_property path"}
sleep 1
current = File.readlines(File.join("/media/mmc1","mplayer-current")).last.sub(/^ANS_path=/,'').chomp

if tag =~ /^0|1|2|3|4$/
  (0..4).each do |n|
    files = read n
    files.delete current
    write n, files
  end
end

files = read tag
files << current
write tag, files
