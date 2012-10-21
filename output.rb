module Output

  def show_team
    puts "Team: #{self.team_name}"
    self.players.each do |pl|
      puts "Name: #{pl.name}   | Hand: #{pl.hand}   | Type: #{pl.type}   | Age: #{pl.age}" 
    end
    puts "\n"
  end

  def show_over
    puts "Over: #{self.over_id} - Bowler: #{self.bowler}"
  end

  def show_over_summary
    puts "Runs from the over: #{self.o_runs}"
    puts "Score:              #{m.current_innings.score}"  
    puts "Run rate:           #{m.current_innings.runs_per_over}"
    puts ""
  end

  def show_ball
    puts "  Ball: #{@ball_in_over}(#{@facing_batsman.name}) - Pitch: #{@pitch} | Length: #{@length} | Spin: #{@spin} | Seam: #{@seam} | Runs: #{@hit.b_runs}"
    sleep 0.2
  end
  
  def show_end
    puts "The final score is #{@score} with a run rate of #{runs_per_over}"
  end
  
  def innings_header
    puts "1st Innings"
    puts "#{@batting_team.team_name} first to bat, with #{@batting_team.players[0].name} and #{@batting_team.players[1].name} opening."
    puts "This is a #{@total_overs} over game."
    puts ""
  end

end
