module Output

  def show_team
    puts "Team: #{self.team_name}"
    self.players.each do |pl|
      puts "Name: #{pl.name}   | Hand: #{pl.hand}   | Type: #{pl.type}   | Age: #{pl.age}" 
    end
    puts "\n"
  end

  def show_over_detail(detail = true)
    puts "Over: #{@current_over.over_id} - Bowler: #{@current_over.bowler}"
    if detail
      @current_over.balls.each do |cb| 
        cb.show_ball
        sleep 0.2
      end
    end
  end

  def show_over_summary
    puts "Runs from the over: #{@current_over.o_runs}"
    puts "Score:              #{@score}"  
    puts "Run rate:           #{runs_per_over}"
    puts ""
  end

  def show_ball
    puts "  Ball: #{@ball_in_over}(#{@facing_batsman.name}) - Pitch: #{@pitch} | Length: #{@length} | Spin: #{@spin} | Seam: #{@seam} | Runs: #{@hit.b_runs}"
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
