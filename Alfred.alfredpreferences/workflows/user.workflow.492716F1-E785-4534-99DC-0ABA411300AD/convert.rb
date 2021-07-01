#!/usr/bin/env ruby
require "json"

fahrenheit = ARGV[0].to_f
celsius = (fahrenheit - 32.0) / (9.0 / 5.0)
results = [
  "%d °F (%d °C)" % [fahrenheit, celsius]
]

list = { items: results.map {|r| { title: r, arg: r } } }

puts list.to_json
