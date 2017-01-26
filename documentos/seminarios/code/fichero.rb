#!/usr/bin/ruby

fh = File::new( ARGV[0] )
while (line = fh.gets ) 
      nombre, apellidos  = line.split(',')
      puts "* Nombre #{nombre}\n\tapellidos #{apellidos}"
end