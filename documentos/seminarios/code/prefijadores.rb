#!/usr/bin/ruby

prefijos = %w( pre post ante super macro mega)
prefijadores = Hash.new
prefijos.each { |p|
  prefijadores[p] = lambda { |post| return "#{p}#{post}";}
}

puts prefijadores['macro'].call( 'objetivo' )
puts prefijadores['super'].call( 'chanchi' )
puts prefijadores['mega'].call( 'chuli' )



