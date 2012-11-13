class Innings < GameComponents
  attr_accessor :score, :wickets, :current_over, :partnership
  attr_reader :innings, :batting_team, :fielding_team, :total_overs, :name, :fall_of_wicket, :over_decimal

  def initialize(name,batting_team, fielding_team, total_overs, target = 0)
    @batting_team     = batting_team
    @fielding_team    = fielding_team
    @name             = name
    @total_overs      = total_overs
    @target           = target
    @facing_b         = @batting_team.players[0]
    @non_striker      = @batting_team.players[1]
    @facing_b.stats_batting[:batted]       = true
    @non_striker.stats_batting[:batted]    = true    
    @score            = 0
    @wickets          = 0
    @current_over     = nil
    @current_over_num = 1
    @current_bowler   = nil
    @innings          = []
    @all_bowlers      = []
    @batted_batters   = []
    @bowled_bowlers   = []
    @fall_of_wicket   = []
    @patnership       = {}
    @fall_of_wicket
    all_bowlers
  end

  def run_innings
    innings_header
    run_overs
    end_of_innings_stats
  end

  def run_overs
    catch (:in_over) do
      @total_overs.times do
        batting_stats
        new_over
        @current_over.run_over
        @innings << @current_over
        new_score
        if @current_over.innings_over == true
          throw :in_over
        end
        close_over
      end
    end
    batters_who_batted
    bowlers_who_bowled
    overs_decimal
  end

  def close_over#
    show_over_summary
    @current_over_num += 1
    facing
  end

  def new_over
    @current_over = Over.new(pick_bowler, @facing_b, @non_striker, @current_over_num, @batting_team, @target, @score)
  end

  def new_score
    @score = @current_over.score
    @wickets = @wickets + @current_over.wickets
  end

  def pick_bowler
    bowlers = []
    @fielding_team.players.each do |pl|
      if pl.type == "Bowler" || pl.type == "All Rounder"
        bowlers << pl
      end
    end
    bowlers.delete(@current_bowler)
    @current_bowler = bowlers.sample
  end

  def all_bowlers
    @fielding_team.players.each do |pl|
      if pl.type == "Bowler" || pl.type == "All Rounder"
        @all_bowlers << pl
      end
    end
  end

  def facing
    @non_striker = @current_over.facing_b
    @facing_b = @current_over.non_striker
  end

  def batters_who_batted
    @batting_team.players.each do |pl|
      if pl.stats_batting[:batted] == true && pl.stats_batting[:balls_faced] > 0
        @batted_batters << pl
      end
    end
  end

  def bowlers_who_bowled
    @all_bowlers.each do |bowler|
      if bowler.stats_bowling[:overs] > 0
        @bowled_bowlers << bowler
      end
    end
  end

  def overs_decimal
    if @current_over.ball_in_over == 7
    @over_decimal = "#{@current_over_num - 1}"
    else  
    @over_decimal = "#{@current_over_num - 1}.#{@current_over.ball_in_over}"
    end
  end

end