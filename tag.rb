#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__),"ftm.rb")

tag = ARGV[0]

if tag =~ /^1|2|3$/ or tag == "DELETE"
  untag "INBOX"
  #[1,2,3,"DELETE"].each { |n| untag n unless n.to_s == tag }
  [1,2,3,"DELETE"].each { |n| untag n.to_s }
end

tag tag
