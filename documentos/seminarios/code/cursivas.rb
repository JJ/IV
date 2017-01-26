#!/usr/bin/ruby

require 'net/http'

url = ARGV[0]
respuesta = Net::HTTP.get  url, '/'
fname = url + ".html"
if ( File.writable?(fname) ) 
   salida = File.new fname, "w"	    
   salida.puts( respuesta )
end