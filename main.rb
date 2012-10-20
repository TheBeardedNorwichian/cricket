##Things to Think about
# - Time!  How to handle the passages of time...
class GameComponents
  include Output
end

class Match < GameComponents
  attr_accessor :team1, :team2, :score, :wickets
  attr_reader :match_arr, :current_over

  def initialize(match_type='50 Over Game')
    @match_arr = []
    @team1 = Team.new('team1.csv',"Bond Street CC")
    @team2 = Team.new('team2.csv',"Norfolk CC")
    @ground = Ground.new()
    @match_type = match_type
    @score = 0
    @wickets = 0
    @current_over = nil
    @current_bowler = nil
    end

  def go
    @score = 0
    @wickets = 0
    run_match
    show_end
  end

  def run_match(total_overs = 20)
    x = 1
    total_overs.times do
      @current_over = Over.new(pick_bowler, x)
      show_over_detail(false)
      @match_arr << @current_over
      x += 1
      @score = @score + @current_over.o_runs
      show_over_summary
    end
  end

  def current_batsmen
  end

  def coin_toss

  end

  def runs_per_over
    (@score.to_f/@current_over.over_id.to_f).rnd_2
  end

  def load_bowlers
  end


  def pick_bowler
    bowlers = []
    @team1.players.each do |pl|
      if pl.type == "Bowler" || pl.type == "All-rounder"
        bowlers << pl.name
      end
    end
    @current_bowler = bowlers.sample
  end

end

class Innings
end