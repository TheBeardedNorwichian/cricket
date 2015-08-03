class Delivery < GameComponents
  attr_accessor :facing_batsman
  attr_reader :status, :ball_in_over, :runs_scored

  def initialize(innings, ball_in_over, bowler, facing_batsman, non_striker, fielding_team)
    @innings        = innings
    @ball_in_over   = ball_in_over
    @bowler         = bowler
    @facing_batsman = facing_batsman
    @non_striker    = non_striker
    @runs_scored    = nil
    @facing_batsman.stats_batting[@innings][:balls_faced] += 1
    @bowler.stats_bowling[@innings][:deliveries] += 1
    @fall_of_wicket = nil
    @ball = nil
    @fielding_team = fielding_team
  end

  def bowl_ball(innings)
    #@bowler.bowl
    #@ball = @bowler.ball
    @facing_batsman.play(@bowler.bowl(@innings), @innings)
    # if @facing_batsman.stats_batting[:out] == true
    #   @bowler.stats_bowling[:wickets] += 1
    #   @facing_batsman.stats_batting[:wicket_taker] = @bowler.name
    # end
    @runs_scored = @facing_batsman.b_runs 
    @bowler.stats_bowling[@innings][:runs_scored] += @facing_batsman.b_runs
    show_ball(innings)
  end

end
