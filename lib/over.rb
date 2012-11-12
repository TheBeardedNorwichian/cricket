class Over < GameComponents
  attr_accessor :facing_b, :non_striker
  attr_reader :balls, :o_runs, :wickets, :bowler, :ball, 
    :over_id, :score, :innings_over, :ball_in_over

  def initialize(bowler, current_batter_1, current_batter_2, over_id, batting_team, target, score)
    @balls        = []
    @o_runs       = 0
    @wickets      = 0
    @score        = score
    @target       = target
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
    #over_heading
    @ball_in_over = 1
    while @balls.length < 6 do 
      @ball = Delivery.new(@ball_in_over, @bowler, @facing_b, @non_striker)
      @ball.bowl_ball
      @balls << @ball
      runs_in_over
      check_for_wicket 
      check_for_end_of_innings
      if @innings_over == true
        break
      end
      @ball_in_over += 1
      facing
    end
  end

  def runs_in_over
    @o_runs += @ball.runs_scored
    @score += @ball.runs_scored
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
    if @target > 0 && @target < @score
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