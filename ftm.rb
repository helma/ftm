#!/usr/bin/env ruby
DIR = "/home/ch/music"

def current 
  #File.open("/tmp/mplayer-input","w+"){|f| f.puts "get_property path"}
  #sleep 1
  #File.readlines("/tmp/mplayer-current").last.sub(/^ANS_path=/,'').chomp
  File.readlines("/tmp/mplayer-current").last.chomp
end

def playlist tag
  File.join(DIR,"playlists","#{tag}.m3u")
end

def playlist_files tag
  File.open(playlist tag).collect { |line| line.chomp unless line.match(/#/) }
end

def tag tag, file=current
  `echo #{file} >> #{playlist(tag)}` unless tagged? tag
end

def untag tag, file=current
  puts "sed -i '/#{file.gsub(%r{/},'\/')}/d' #{playlist(tag)}" if tagged? tag
  `sed -i '/#{file.gsub(%r{/},'\/')}/d' #{playlist(tag)}` if tagged? tag
end

def tags file=current
  `grep -l '#{file}' #{File.join(DIR,"playlists","*.m3u")}`.split("\n").collect{|f| File.basename(f,".m3u")}
end

def tagged? tag, file=current
  tags(file).include? tag
end
