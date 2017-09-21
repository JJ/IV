#!/usr/bin/ruby

host = ARGV[0]
partes = host.split(".")
partes.each { |p|
  puts "* #{p}"
}
