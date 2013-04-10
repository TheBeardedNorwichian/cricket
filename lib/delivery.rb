class Delivery < GameComponents
  attr_accessor :facing_batsman
  attr_reader :status, :ball_in_over, :runs_scored

  def initialize(ball_in_over, bowler, facing_batsman, non_striker)
    @ball_in_over   = ball_in_over
    @bowler         = bowler
    @facing_batsman = facing_batsman
    @non_striker    = non_striker
    @runs_scored    = nil
    @facing_batsman.stats_batting[:balls_faced] += 1
    @bowler.stats_bowling[:deliveries] += 1
    @fall_of_wicket = nil
    @ball = nil
  end

  def bowl_ball
    @bowler.bowl
    @ball = @bowler.ball
    is_hit
    show_ball
  end

  def is_hit
    ball_sum = @ball[:length] + @ball[:pitch] + @ball[:speed]
    if ball_sum > 50
      @facing_batsman.hit
      @runs_scored = @facing_batsman.b_runs
      if @runs_scored == 0
        @facing_batsman.stats_batting[:dot_balls] += 1
      end
      @bowler.stats_bowling[:runs_scored] += @runs_scored
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
