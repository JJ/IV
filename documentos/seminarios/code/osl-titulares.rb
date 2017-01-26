#!/usr/bin/ruby

require 'rubygems'
require 'hpricot'
require 'open-uri'

osl =  Hpricot(open("http://osl.ugr.es/"))
osl.search("//h2[@class='entry-title']").each { |h2|
  this_h2 = Hpricot( h2.to_s )
<<<<<<< HEAD
  link = this_h2.search("a[@href]").text
=======
  link = this_h2.search("a[@href]").inner_html
>>>>>>> 3bd00d4f0b77bb8b520e874d7ea3febf1d4bf23b
  text = this_h2.at("a").inner_html
  puts "#{link} => #{text}"
}
