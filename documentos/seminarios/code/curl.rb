#!/usr/bin/ruby

require 'net/http'

url = ARGV[0]
puts "La url es " << url
respuesta = Net::HTTP.get  url, '/'
fname =  "#{url}.html"
#Que lo crees antes, pardillo
if ( File.writable?(fname) ) 
  salida = File.new fname, "w"	    
  salida.puts( respuesta )
else
  puts("No puedo escribir en #{fname}")
end
