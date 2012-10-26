module Output

  def innings_header
    puts "1st Innings"
    puts "#{@batting_team.team_name} first to bat, with #{@batting_team.players[0].name} and #{@batting_team.players[1].name} opening."
    puts "This is a #{@total_overs} over game."
    puts ""
  end

  def show_team
    puts "Team: #{self.team_name}"
    self.players.each do |pl|
      puts "Name: #{pl.name}   | Hand: #{pl.hand}   | Type: #{pl.type}   | Age: #{pl.age}" 
    end
    puts "\n"
  end

  def over_heading
    puts "Over: #{self.over_id} - Bowler: #{self.bowler.name}"
  end

  def show_over_summary
    puts "Runs from the over: #{@current_over.o_runs}"
    puts "Score:              #{@score}"  
    puts "Run rate:           #{runs_per_over}"
    puts ""
  end

  def show_ball
    #puts "  Ball: #{@ball_in_over}(#{@facing_batsman.name}) | Runs: #{@hit.b_runs}"
    #sleep 0.1
  end
  
  def innings_summary
    puts "The final score is #{@score} with a run rate of #{runs_per_over}"
  end

  def end_of_innings_stats#
    puts "B A T T I N G   S T A T S"
    @batted_batters.each do |batter|
      puts "Stats for: #{batter.name}"
      puts "Batted?       #{batter.stats_batting[:batted]}"
      puts "Balls faced:  #{batter.stats_batting[:balls_faced]}"
      puts "Dot balls:    #{batter.stats_batting[:dot_balls]}"
      puts "Runs scored:  #{batter.stats_batting[:runs_scored]}"
      puts "Fours:        #{batter.stats_batting[:fours_hit]}"
      puts "Sixes:        #{batter.stats_batting[:sixes_hit]}"
      puts "Strike rate:  #{batter.strike_rate}"
      puts ""
    end
    puts "B O W L I N G   S T A T S"
    @all_bowlers.each do |bowler|
      puts "Stats for: #{bowler.name}"
      puts "Overs:        #{bowler.stats_bowling[:overs]}"
      puts "Balls bowled: #{bowler.stats_bowling[:deliveries]}"
      puts "Runs_scored:  #{bowler.stats_bowling[:runs_scored]}"
      puts "Economy:      #{bowler.economy}"
      puts "Wickets:      #{bowler.stats_bowling[:wickets]}"
      puts "No Balls:     #{bowler.stats_bowling[:no_balls]}"
      puts "Wides:        #{bowler.stats_bowling[:wides]}"
      puts ""
    end
  end

end
