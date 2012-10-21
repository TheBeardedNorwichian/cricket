class GameComponents
  include Output
end


#basic match container
class Match < GameComponents
  attr_accessor :team1, :team2
  attr_reader :match_arr, :current_innings

#detail refers to test output - basically a ball-by-ball desription.
  def initialize(detail = true, total_overs = 20)
    @match_arr = []
    @team1 = Team.new('team1.csv',"Bond Street CC")
    @team2 = Team.new('team2.csv',"Norfolk CC")
    @ground = Ground.new()
    @total_overs = total_overs
  end

  def go
    if coin_toss
      @current_innings = Innings.new(@team1, @team2, @total_overs)
      @first_innings = @current_innings
      @current_innings = Innings.new(@team2, @team1, @total_overs)
    else
      @current_innings = Innings.new(@team2, @team1, @total_overs)
      @first_innings = @current_innings
      @current_innings = Innings.new(@team1, @team2, @total_overs)
    end
  end
end

class Innings < GameComponents
  attr_accessor :score, :wickets

  def initialize(batting_team, fielding_team, total_overs)
    @batting_team = batting_team
    @fielding_team = fielding_team
    @score = 0
    @wickets = 0
    @total_overs = total_overs
    @current_over = nil
    @current_bowler = nil
    @current_batter_1 = @batting_team.players[0]
    @current_batter_2 = @batting_team.players[1]
    @innings = []
  end

  def run_innings
    innings_header
    x = 1
    @total_overs.times do
      @current_over = Over.new(pick_bowler, @current_batter_1, @current_batter_2, x)
      @innings << @current_over
      x += 1
      @score = @score + @current_over.o_runs
    end
  end

  def runs_per_over
    (@score.to_f/@current_over.over_id.to_f).rnd_2
  end

  def pick_bowler
    bowlers = []
    @fielding_team.players.each do |pl|
      if pl.type == "Bowler" || pl.type == "All-rounder"
        bowlers << pl.name
      end
    end
    bowlers.delete(@current_bowler)
    @current_bowler = bowlers.sample
  end
end