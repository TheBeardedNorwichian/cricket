class Control < GameComponents
  attr_accessor :match

  def go
    @match = Match.new(40)  
    @match.first_innings
    @match.current_innings.run_innings
    @match.target = @match.current_innings.score
    @match.second_innings
    @match.current_innings.run_innings
    @match.check_winner
  end
end