class Control < GameComponents
  attr_accessor :match

  def go
    @match = Match.new(50)
    @match.team1.show_team
    @match.team2.show_team
    @match.new_innings
    @match.current_innings.run_innings
  end
end