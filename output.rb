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
    puts "Runs from the over:    #{@current_over.o_runs}"
    puts "Wickets from the over: #{@current_over.wickets}"
    puts "Score:                 #{@score} / #{@wickets}"  
    puts "Run rate:              #{runs_per_over}"
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

  def end_of_innings_stats
    puts ""
    @batted_batters.each do |b|
      puts "#{pad_l(b.name,20)} - #{pad_l(b.stats_batting[:wicket_taker],15)} | #{pad_r(b.stats_batting[:runs_scored],3)} | #{pad_r(b.stats_batting[:balls_faced],3)} | #{pad_r(b.strike_rate,6)} | #{pad_r(b.stats_batting[:dot_balls],2)} | #{pad_r(b.stats_batting[:fours_hit],2)} | #{pad_r(b.stats_batting[:sixes_hit],2)} "
    end
    puts ""
    puts " - #{@score}/#{@wickets} - "
    puts ""
    puts "B O W L I N G   S T A T S"
    puts ""
    @all_bowlers.each do |b|
      puts "#{pad_l(b.name,20)} | #{pad_r(b.stats_bowling[:overs],2)} | #{pad_r(b.stats_bowling[:deliveries],3)} | #{pad_r(b.stats_bowling[:wickets],2)} | #{pad_r(b.stats_bowling[:runs_scored],2)} | #{pad_r(b.economy,5)} | #{pad_r(b.stats_bowling[:no_balls],2)} | #{pad_r(b.stats_bowling[:wides],2)}"
    end
    puts ""
  end

  def pad_l(string, size)
    pad = size - string.to_s.length
    return "#{string}" + " " * pad
  end

  def pad_r(string, size)
    pad = size - string.to_s.length
    return " " * pad + "#{string}"
  end


  def format(string)
    return sprintf '%02d', string
  end
end
