#!/usr/bin/env ruby

tagged = Dir["./playlists/[1-4].m3u"].collect do |m3u|
    File.open(m3u).collect { |line| line.chomp unless line.match(/#/) }
end.flatten.compact.uniq
File.open(File.join(File.dirname(__FILE__), "playlists", "0.m3u"), "w+") do |m3u|
  m3u.puts "#EXTM3U"
  (Dir["#{ARGV[0]}/**/*.{mp3,MP3,ogg,wav,WAV,flac,aiff}"] - tagged).uniq.shuffle.each do |file|
    m3u.puts file
  end
end
