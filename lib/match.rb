require 'control.rb'

class Match < GameComponents
  attr_accessor :team1, :team2, :current_innings, :target, :score
  attr_reader :match_hash

  def initialize(total_overs = 90)
    @match_hash       = {}
    @team2            = Team.new('./lib/Teams/Australia.csv',"Australia")
    @team1            = Team.new('./lib/Teams/England.csv',"England")
    @ground           = Ground.new()
    @total_overs      = total_overs
    @first_innings    = nil
    @second_innings   = nil
    @target           = 0
  end

  def first_innings
    @current_innings  = Innings.new("First Innings",@team1, @team2, @total_overs)
    @first_innings    = @current_innings
    @target = @current_innings.score
  end

  def second_innings
    @current_innings  = Innings.new("Second Innings",@team2, @team1, @total_overs, @target)
    @second_innings   = @current_innings
  end

  def check_winner
    if @first_innings.score > @second_innings.score
      team_win = "# #{@team1.team_name} beat #{@team2.team_name} by #{win_score(@first_innings.score, @second_innings.score)} runs. #"
    else
      team_win ="# #{@team2.team_name} beat #{@team1.team_name} by #{10 - @second_innings.wickets} wickets. #"
    end
    puts "#" * (team_win.length)
    puts team_win
    puts "#" * (team_win.length)
  end

  def win_score(score1, score2)
    return score1 - score2
  end

  def balls_remaining
    (@total_overs * 6)
  end
end
