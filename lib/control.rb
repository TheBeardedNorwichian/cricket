$: << File.dirname(__FILE__)

require 'output'
require 'game_components'
require 'things'
require 'player'
require 'functions'
require 'match'
require 'innings'
require 'over'
require 'delivery'
require 'hit'

class Control < GameComponents
  attr_accessor :match, :details

  def self.set_details(bool)
    @@details = bool
  end

  def self.details
    @@details
  end

  def self.go
    @match = Match.new(150)
    @match.first_innings
    @match.current_innings.run_innings
    @match.target = @match.current_innings.score
    @match.second_innings
    @match.current_innings.run_innings
    @match.check_winner
  end

end