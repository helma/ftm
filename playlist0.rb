#!/usr/bin/env ruby

tagged = Dir[File.join(ARGV[0],"playlists/[1-4].m3u")].collect do |m3u|
    File.open(m3u).collect { |line| line.chomp unless line.match(/#/) }
end.flatten.compact.uniq
File.open(File.join(ARGV[0], "playlists", "0.m3u"), "w+") do |m3u|
  m3u.puts "#EXTM3U"
  (Dir["#{ARGV[0]}/music/**/*.{mp3,MP3,ogg,wav,WAV,flac,aiff}"] - tagged).uniq.shuffle.each do |file|
    m3u.puts file
  end
end
