require File.dirname(__FILE__) + '/lib/control'

system('clear')
system('cls')

Control.set_details(true)
trap("SIGINT") {puts " You decided to exit the game - silly you!"; exit}
Control.go
