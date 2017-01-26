#!/usr/bin/ruby

require 'net/http'

url = ARGV[0]
<<<<<<< HEAD
puts "La url es " << url
respuesta = Net::HTTP.get  url, '/'
fname =  "#{url}.html"
#Que lo crees antes, pardillo
=======
respuesta = Net::HTTP.get  url, '/'
fname =  "#{url}.html"
>>>>>>> 3bd00d4f0b77bb8b520e874d7ea3febf1d4bf23b
if ( File.writable?(fname) ) 
  salida = File.new fname, "w"	    
  salida.puts( respuesta )
else
  puts("No puedo escribir en #{fname}")
end
