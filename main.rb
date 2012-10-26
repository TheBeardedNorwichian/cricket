class GameComponents
  include Output
  include Attributes
end


class Match < GameComponents
  attr_accessor :team1, :team2, :current_innings, :first_innings_1, :first_innings_2
  attr_reader :match_arr

  def initialize(total_overs = 20)
    @match_arr = []
    @team1 = Team.new('team1.csv',"Bond Street CC")
    @team2 = Team.new('team2.csv',"Norfolk CC")
    @ground = Ground.new()
    @total_overs = total_overs
  end

  def go
    # if coin_toss
      puts "#{@team1.team_name} are batting first"
      @first_innings_1 = Innings.new(@team1, @team2, @total_overs)
      @first_innings_1.go
      # @first_innings_2 = Innings.new(@team2, @team1, @total_overs)
    #  else
      # puts "#{@team2.team_name} are batting first"
      # @first_innings_1 = Innings.new(@team2, @team1, @total_overs)
      # @first_innings_2 = Innings.new(@team1, @team2, @total_overs)
    # end
  end
end




class Innings < GameComponents
  attr_accessor :score, :wickets, :current_over
  attr_reader :innings, :batting_team, :fielding_team

  def initialize(batting_team, fielding_team, total_overs)
    @batting_team = batting_team
    @fielding_team = fielding_team
    @score = 0
    @wickets = 0
    @total_overs = total_overs
    @current_over = nil
    @current_over_num = 1
    @current_bowler = nil
    @facing_b = @batting_team.players[0]
    @non_striker = @batting_team.players[1]
    @innings = []
    @all_bowlers = []
    @batted_batters = []
    all_bowlers
  end

  def go
    run_innings
    batters_who_batted
    end_of_innings_stats
  end

  def run_innings
    innings_header
    @facing_b.stats_batting[:batted]       = true
    @non_striker.stats_batting[:batted]    = true    
    @total_overs.times { run_over }
    innings_summary
  end

  def run_over
    new_over
    @current_over.run_over
    @innings << @current_over
    new_score
    show_over_summary
    @current_over_num += 1
    facing
  end

  def new_over
    @current_over = Over.new(pick_bowler, @facing_b, @non_striker, @current_over_num)
  end

  def runs_per_over
    (@score.to_f/@current_over_num.to_f).rnd_2
  end

  def new_score
    @score = @score + @current_over.o_runs
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
      else
        puts "You are an idiot!"
      end
    end
  end
end




class Over < GameComponents
  attr_accessor :facing_b, :non_striker
  attr_reader :balls, :o_runs, :wickets, :bowler, :ball, :over_id, :score

  def initialize(bowler, current_batter_1, current_batter_2, over_id)
    @balls = []
    @o_runs = 0
    @wickets = 0
    @bowler = bowler
    @facing_b = current_batter_1
    @non_striker = current_batter_2
    @over_id = over_id
    @ball
    @bowler.stats_bowling[:overs] += 1
  end

  def run_over
    over_heading
    ball_in_over = 1
    while @balls.length < 6 do 
      @ball = Delivery.new(ball_in_over, @bowler, @facing_b, @non_striker)
      @ball.bowl_ball
      @balls << @ball 
      ball_in_over += 1
      runs_in_over
      facing
    end
  end

  def runs_in_over
    @o_runs += @ball.runs_scored
  end

  def facing
    old_face     = @facing_b
    new_face     = @non_striker 
    if @ball.runs_scored % 2 != 0
      @facing_b = new_face
      @non_striker = old_face
    end
  end
end




class Delivery < GameComponents
  attr_reader :pitch, :length, :speed, :spin, :seam, :status, :ball_in_over, :hit, :runs_scored

  def initialize(ball_in_over, bowler, facing_batsman, non_striker)
    @pitch = sprintf '%02d', random
    @length = sprintf '%02d', random
    @speed = sprintf '%02d', random
    @spin = sprintf '%02d', random
    @seam = sprintf '%02d', random
    @ball_in_over = ball_in_over
    @bowler = bowler
    @facing_batsman = facing_batsman
    @non_striker = non_striker
  end

  def bowl_ball
    delivery_stats
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
    @hit = Hit.new(@facing_batsman, @bowler, true)
    @runs_scored = @hit.b_runs
  end

  def wicket
  end

end


class Hit < GameComponents
  attr_reader :b_runs
  def initialize(batsman, bowler, hit)
    @batsman = batsman
    @bowler = bowler
    @is_hit = hit
    get_score
  end

  def get_score
    if @is_hit == true
      @b_runs = random_run_engine
      if @b_runs > 0
        @batsman.stats_batting[:runs_scored] += @b_runs
        @bowler.stats_bowling[:runs_scored] += @b_runs
        if @b_runs == 4
          @batsman.stats_batting[:fours_hit] += 1
        end
        if @b_runs == 6
          @batsman.stats_batting[:sixes_hit] += 1
        end
      else
        @batsman.stats_batting[:dot_balls] += 1
      end
    else
      @b_runs = 0
      @batsman.stats_batting[:dot_balls] += 1
    end
  end
end