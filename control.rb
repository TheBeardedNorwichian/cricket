class Control < GameComponents
  attr_accessor :match

  def go
    @match = Match.new(50)
    @match.team1.show_team
    @match.team2.show_team
    @match.new_innings
    @match.current_innings.innings_header
    @match.current_innings.total_overs.times { @match.current_innings.run_over }
    @match.current_innings.batters_who_batted
    @match.current_innings.end_of_innings_stats
  end
end