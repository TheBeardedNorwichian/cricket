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
    if coin_toss
      puts "#{@team1.team_name} are batting first"
      @first_innings_1 = Innings.new(@team1, @team2, @total_overs)
      @first_innings_2 = Innings.new(@team2, @team1, @total_overs)
    else
      puts "#{@team2.team_name} are batting first"
      @first_innings_1 = Innings.new(@team2, @team1, @total_overs)
      @first_innings_2 = Innings.new(@team1, @team2, @total_overs)
    end
  end
end




class Innings < GameComponents
  attr_accessor :score, :wickets, :current_over
  attr_reader :innings

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
    run_innings
  end

  def run_innings
    innings_header
    @total_overs.times { run_over }
    innings_summary
  end

  def new_over
    @current_over = Over.new(pick_bowler, @facing_b, @non_striker, @current_over_num)
  end

  def run_over
    new_over
    @innings << @current_over
    new_score
    show_over_summary
    @current_over_num += 1
    facing
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
        bowlers << pl.name
      end
    end
    bowlers.delete(@current_bowler)
    @current_bowler = bowlers.sample
  end

  def facing
    @non_striker = @current_over.facing_b
    @facing_b = @current_over.non_striker
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
    show_over
    run_over
  end

  def run_over
    ball_in_over = 1
    while @balls.length < 6 do 
      @ball = Delivery.new(ball_in_over, @bowler, @facing_b, @non_striker)
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
    is_hit
    show_ball    
  end

  def random
    rand(100)
  end

  def wicket
  end

  def is_hit
    @hit = Hit.new(@facing_batsman, true)
    @runs_scored = @hit.b_runs
  end
end


class Hit < GameComponents
  attr_accessor :b_runs
  def initialize(batsman, hit)
    @batsman = batsman
    @is_hit = hit
    get_score
  end

  def get_score
    if @is_hit == true
      @b_runs = random_run_engine
      if @b_runs > 0
        @batsman.stats[:runs_scored] = @b_runs
      end
    else
      @b_runs = 0
    end
  end
end