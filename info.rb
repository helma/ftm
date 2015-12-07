#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__),"ftm.rb")

file = current
print File.basename(file)+": "
puts tags(file).join(", ")
