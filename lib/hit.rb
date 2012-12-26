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
