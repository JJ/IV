#!/usr/bin/ruby

require 'rubygems'
require 'hpricot'
require 'open-uri'

osl =  Hpricot(open("http://osl.ugr.es/"))
osl.search("//h2[@class='entry-title']").each { |h2|
  this_h2 = Hpricot( h2.to_s )
  link = this_h2.search("a[@href]").text
  text = this_h2.at("a").inner_html
  puts "#{link} => #{text}"
}
