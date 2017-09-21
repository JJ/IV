#!/usr/bin/ruby

require 'net/http'

url = ARGV[0]
respuesta = Net::HTTP.get  url, '/'
titulares=respuesta.match("<em>(.+)</em")
salida = File.new url << "-titulares.txt", "w"
salida.puts( titulares[1..titulares.size].join("\n"))