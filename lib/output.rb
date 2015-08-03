module Output

  def innings_header
    1.times { puts "" }
    puts "#################################################################"
    puts "#{@innings_name}"
    puts ""
  end

  def show_team
    puts "Team: #{@team_name}"
    self.players.each do |pl|
      puts "#{pad_l(pl.name,17)} | #{pad_l(pl.hand,6)} | #{pad_l(pl.type,13)} | #{pad_l(pl.age,2)}" 
    end
    puts "\n"
  end

  def over_heading
    if Control.details == true
      puts "Over: #{@over_id} - Bowler: #{@bowler.name}"
    end
  end

  def show_ball(innings)
    if Control.details == true
      #end_of_innings_stats
      puts "  Ball: #{@ball_in_over} - #{show_wicket}     | #{pad_l(@facing_batsman.name,20)} - #{pad_r(@facing_batsman.stats_batting[innings][:runs_scored],3)}"
      sleep 0.3
    end
  end
  
  def show_wicket
    if @facing_batsman.stats_batting[:out] == true 
      return "Wicket!"
    else 
      return "Runs: #{@runs_scored}"
    end
  end

  def show_over_summary
    if Control.details == true
      puts "Runs from the over:    #{@current_over.o_runs}"
      puts "Wickets from the over: #{@current_over.wickets}"
      puts "Score:                 #{@score} / #{@wickets}"  
      puts "Run rate:              #{runs_per_over}"
      puts ""
      sleep 3
      system 'cls'
      system 'clear'
    end
  end

  def innings_summary
    if @wickets == 10 
      puts "The final score is #{@score} all out in #{overs_decimal} overs." 
    else
      puts "The final score is #{@score} for #{@wickets}"
    end
  end   

  def end_of_innings_stats(innings)
    batting_stats(innings)
    #fall_of_wicket
    bowling_stats(innings)
  end

  def batting_stats(innings)
    @batted_batters.each do |b|
      puts "#{pad_l(b.name,20)} - #{pad_l(b.stats_batting[innings][:howout], 25)} #{pad_l(b.stats_batting[innings][:wicket_taker],40)} #{pad_r(b.stats_batting[innings][:runs_scored],3)} | #{pad_r(b.stats_batting[innings][:balls_faced],3)} | #{pad_r(b.strike_rate(innings),6)} | #{pad_r(b.stats_batting[innings][:fours_hit],2)} | #{pad_r(b.stats_batting[innings][:sixes_hit],2)} "
    end
    puts ""
    if @wickets == 10
      puts " - #{@score} all out (#{@over_decimal} overs) at #{runs_per_over} runs per over."
    else
      puts " - #{@score} for #{@wickets} (#{@over_decimal} overs) at #{runs_per_over} runs per over."
    end
    puts ""
  end

  def fall_of_wicket
    @batting_team.score.each do |x, y|
      print "#{x}-#{y} | "
    end
  end

  def bowling_stats(innings)
    puts ""
    puts ""
    @bowled_bowlers.each do |b|
      puts "#{pad_l(b.name,20)} - #{pad_r(b.energy, 4)} | #{pad_r(b.stats_bowling[innings][:overs],3)} | #{pad_r(b.stats_bowling[innings][:maidens],3)} | #{pad_r(b.stats_bowling[:wickets],2)} | #{pad_r(b.stats_bowling[innings][:runs_scored],3  )} | #{pad_r(b.economy(innings),5)} | #{pad_r(b.stats_bowling[innings][:no_balls],2)} | #{pad_r(b.stats_bowling[innings][:wides],2)}"
    end
    puts ""
  end

  def format(float)
    return sprintf '%02d', float
  end

  def runs_per_over
    (@score.to_f / @current_over_num.to_f).rnd_2
  end

end
