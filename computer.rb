#!/usr/bin/env ruby
require './expression.rb'
require './polynomial.rb'
require './math.rb'
require 'pry'
require 'awesome_print'

if ARGV[0].nil? || !ARGV[0].match(/.+ = .+/)
  puts 'Please input a valid 2nd degree polynomial to resolve as a quoted arguement.'
  exit
end

polynomial = Polynomial.new(ARGV[0].upcase.tr(' ', ''))
polynomial.resolve
