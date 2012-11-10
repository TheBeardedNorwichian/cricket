class GameComponents
  include Output
  include Attributes
end


class Match < GameComponents
  attr_accessor :team1, :team2, :current_innings
  attr_reader :match_arr

  def initialize(total_overs = 90)
    @match_arr        = []
    @team1            = Team.new('team1.csv',"Bond Street CC")
    @team2            = Team.new('team2.csv',"England")
    @ground           = Ground.new()
    @total_overs      = total_overs
    @first_innings    = nil
    @second_innings   = nil
  end

  def first_innings
    @current_innings  = Innings.new("First Innings",@team1, @team2, @total_overs)
    @first_innings    = @current_innings
  end

  def second_innings
    @current_innings  = Innings.new("Second Innings",@team2, @team1, @total_overs)
    @second_innings   = @current_innings
  end

  def check_winner
    if @first_innings.score > @second_innings.score
      team_win = "# #{@team1.team_name} beat #{@team2.team_name} by #{win_score(@first_innings.score, @second_innings.score)} runs. #"
    else
      team_win ="# #{@team2.team_name} beat #{@team1.team_name} by #{win_score(@second_innings.score, @first_innings.score)} runs. #"
    end
    puts "#" * (team_win.length)
    puts team_win
    puts "#" * (team_win.length)
  end

  def win_score(score1, score2)
    return score1 - score2
  end
end




class Innings < GameComponents
  attr_accessor :score, :wickets, :current_over
  attr_reader :innings, :batting_team, :fielding_team, :total_overs, :name, :fall_of_wicket

  def initialize(name,batting_team, fielding_team, total_overs)
    @batting_team     = batting_team
    @fielding_team    = fielding_team
    @name             = name
    @total_overs      = total_overs
    @facing_b         = @batting_team.players[0]
    @non_striker      = @batting_team.players[1]
    @facing_b.stats_batting[:batted]       = true
    @non_striker.stats_batting[:batted]    = true    
    @score            = 0
    @wickets          = 0
    @current_over     = nil
    @current_over_num = 0
    @current_bowler   = nil
    @innings          = []
    @all_bowlers      = []
    @batted_batters   = []
    @fall_of_wicket   = []
    @patnership       = {}
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
        new_over
        @current_over.run_over
        @innings << @current_over
        new_score
        close_over
        show_over_summary
        if @current_over.innings_over == true
          throw :in_over
        end

      end
    end
    batters_who_batted
  end

  def close_over
    @current_over_num += 1
    facing
  end

  def new_over
    @current_over = Over.new(pick_bowler, @facing_b, @non_striker, @current_over_num, @batting_team)
  end

  def new_score
    @score = @score + @current_over.o_runs
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
      if pl.stats_batting[:batted] == true
        @batted_batters << pl
      end
    end
  end
end




class Over < GameComponents
  attr_accessor :facing_b, :non_striker
  attr_reader :balls, :o_runs, :wickets, :bowler, :ball, 
    :over_id, :score, :innings_over, :ball_in_over

  def initialize(bowler, current_batter_1, current_batter_2, over_id, batting_team)
    @balls        = []
    @o_runs       = 0
    @wickets      = 0
    @bowler       = bowler
    @facing_b     = current_batter_1
    @non_striker  = current_batter_2
    @batting_team = batting_team
    @over_id      = over_id
    @ball         = nil
    @bowler.stats_bowling[:overs] += 1
    @innings_over = false
    @ball_in_over = nil
  end

  def run_over
    over_heading
    @ball_in_over = 1
    while @balls.length < 6 do 
      @ball = Delivery.new(@ball_in_over, @bowler, @facing_b, @non_striker)
      @ball.bowl_ball
      @balls << @ball
      check_for_wicket 
      check_for_end_of_innings
      if @innings_over == true
        break
      end
      @ball_in_over += 1
      runs_in_over
      facing
    end
  end

  def runs_in_over
    @o_runs += @ball.runs_scored
  end

  def check_for_wicket
    if @ball.facing_batsman.stats_batting[:out] == true
      @wickets += 1
      @batting_team.players.each do |batter|
        if batter.stats_batting[:out] == false && batter.stats_batting[:batted] == false
          @facing_b = batter
          batter.stats_batting[:batted] = true
          break
        end
      end
    end
  end

  def check_for_end_of_innings
    total_wickets = 0
    @batting_team.players.each do |batter|
      if batter.stats_batting[:out] == true
        total_wickets += 1
      end
    end
    if total_wickets == 10
      @innings_over = true
    end
  end

  def facing
    old_face     = @facing_b
    new_face     = @non_striker 
    if @ball.runs_scored % 2 != 0
      @facing_b     = new_face
      @non_striker  = old_face
    end
  end
end




class Delivery < GameComponents
  attr_accessor :facing_batsman
  attr_reader :pitch, :length, :speed, :spin, :seam, :status, 
    :ball_in_over, :hit, :runs_scored

  def initialize(ball_in_over, bowler, facing_batsman, non_striker)
    @pitch          = sprintf '%02d', random
    @length         = sprintf '%02d', random
    @speed          = sprintf '%02d', random
    @spin           = sprintf '%02d', random
    @seam           = sprintf '%02d', random
    @ball_in_over   = ball_in_over
    @bowler         = bowler
    @facing_batsman = facing_batsman
    @non_striker    = non_striker
    @runs_scored    = nil
  end

  def bowl_ball
    delivery_stats
    #bowl ball
    is_hit
    show_ball
  end

  def random
    rand(100)
  end

  def delivery_stats
    @facing_batsman.stats_batting[:balls_faced] += 1
    @bowler.stats_bowling[:deliveries] += 1
  end

  def is_hit
    r = random
    if r < 96
      @hit = Hit.new(@facing_batsman, @bowler)
      @runs_scored = @hit.b_runs
      if @runs_scored == 0
        @facing_batsman.stats_batting[:dot_balls] += 1
      end
    else
      wicket
      @runs_scored = 0
    end
  end

  def wicket
    @facing_batsman.stats_batting[:out] = true
    @facing_batsman.stats_batting[:wicket_taker] = @bowler.name
    @bowler.stats_bowling[:wickets] += 1
  end
end

class Hit < GameComponents
  attr_reader :b_runs
  def initialize(batsman, bowler)
    @batsman    = batsman
    @bowler     = bowler
    get_score
  end

  def get_score
    @b_runs = random_run_engine(@batsman.batting_attr[:batting])
    if @b_runs > 0
      @batsman.stats_batting[:runs_scored] += @b_runs
      @bowler.stats_bowling[:runs_scored] += @b_runs
      if @b_runs == 4
        @batsman.stats_batting[:fours_hit] += 1
      end
      if @b_runs == 6
        @batsman.stats_batting[:sixes_hit] += 1
      end
    end
  end
end
