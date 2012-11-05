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
      puts "Name: #{pl.name} | Hand: #{pl.hand}   | Type: #{pl.type}   | Age: #{pl.age}" 
    end
    puts "\n"
  end

  def over_heading
    puts "Over: #{self.over_id} - Bowler: #{self.bowler.name}"
  end

  def show_over_summary
    puts "Runs from the over: #{@current_over.o_runs}"
    puts "Score:              #{@score} / #{@wickets}"  
    puts "Run rate:           #{runs_per_over}"
    puts ""
  end

  def show_ball
    #puts "  Ball: #{@ball_in_over}(#{@facing_batsman.name}) | Runs: #{@hit.b_runs}"
    #sleep 0.1
  end
  
  def innings_summary
    puts "The final score is #{@score} for #{@wickets} with a run rate of #{runs_per_over}"
    puts ""
  end

  def end_of_innings_stats#
    puts "B A T T I N G   S T A T S"
    puts ""
    @batted_batters.each do |b|
      puts "#{padding(b.name,20)} | #{padding(b.stats_batting[:runs_scored],2)} | #{padding(b.stats_batting[:balls_faced],2)} | #{padding(b.strike_rate,6)} | #{padding(b.stats_batting[:dot_balls],2)} | #{padding(b.stats_batting[:fours_hit],2)} | #{padding(b.stats_batting[:sixes_hit],2)} "
    end
    puts ""
    puts "B O W L I N G   S T A T S"
    puts ""
    @all_bowlers.each do |b|
      puts "#{padding(b.name,20)} | #{padding(b.stats_bowling[:overs],2)} | #{padding(b.stats_bowling[:deliveries],3)} | #{padding(b.stats_bowling[:wickets],2)} | #{padding(b.stats_bowling[:runs_scored],2)} | #{padding(b.economy,5)} | #{padding(b.stats_bowling[:no_balls],2)} | #{padding(b.stats_bowling[:wides],2)}"
    end
    puts ""
  end

  def padding(string, size)
    padding = size - string.to_s.length
    return "#{string}" + " " * padding
  end

  def format(string)
    return sprintf '%02d', string
  end
end
