$: << File.dirname(__FILE__)

require File.dirname(__FILE__) + '/lib/control'

require 'rubygems'
require 'bundler'
Bundler.require(:default)

system('clear')
system('cls')

Control.set_details(false)
trap("SIGINT") {puts " You decided to exit the game - silly you!"; exit}
Control.go
