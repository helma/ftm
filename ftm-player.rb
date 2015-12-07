#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__),"ftm.rb")
`rm -f /tmp/mplayer-input`
`mkfifo /tmp/mplayer-input`
`killall xbindkeys`
`killall mplayer`
`xbindkeys -f $HOME/src/ftm/xbindkeysrc`

#`echo "" > /tmp/mplayer-input`
#`xbindkeys -f ~/src/ftm/xbindkeysrc`
#puts `xbindkeys -s`
playlist_files(ARGV[0]).shuffle.each do |file|
  puts file
  `echo "#{file}" > /tmp/mplayer-current`
  #`mplayer -nolirc -slave -idle -quiet -msglevel all=-1 -msglevel global=5 -input file=/tmp/mplayer-input #{file}`
  puts "mplayer -nolirc -quiet -msglevel all=-1 -msglevel global=5 -input file=/tmp/mplayer-input #{file}"
  `mplayer -nolirc -quiet -msglevel all=-1 -msglevel global=5 -input file=/tmp/mplayer-input #{file}`
end
