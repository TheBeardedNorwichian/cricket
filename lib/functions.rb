def random_run_engine(bat_var)
  y = rand(100) - 20
  x = y + bat_var

  one_run       = 50
  two_runs      = 75
  three_runs    = 88
  four_runs     = 91
  six_runs      = 98

  if x >= 0 && x < one_run
    return 0
  elsif x >= one_run && x < two_runs
    return 1
  elsif x >= two_runs && x < three_runs
    return 2
  elsif x >= three_runs && x < four_runs
    return 3
  elsif x >= four_runs && x < six_runs
    return 4
  elsif x >= six_runs && x <= 100
    return 6
  else
    return 0
  end
end

def show_age(dob)
  now = Time.now
  true_dob = Date.parse dob
  now.year - true_dob.year
end

def pad_l(string, size)
  pad = size - string.to_s.length
  return "#{string}" + " " * pad
end

def pad_r(string, size)
  pad = size - string.to_s.length
  return " " * pad + "#{string}"
end

class Float
  def rnd_2
    (self*100).round / 100.0
  end
end

def how_out(batsman, bowler, fielding_team)
  
  x = rand
  wicket_keeper = ""
  catchers = []
  fielding_team.players.each do |pl|
    if pl.type != "Wicket Keeper"
      catchers << pl
    else wicket_keeper = pl  
    end
  end

  bowled        =  0.18
  lbw           =  0.35
  caught_behind =  0.53
  caught        =  0.95
  stumped       =  0.97

  fielder = catchers.sample

  if x >= 0 && x < bowled
      batsman.stats_batting[:wicket_taker] = "b #{bowler.name}"
      batsman.stats_batting[:howout] = ""
      bowler.stats_bowling[:wickets] += 1
    elsif x >= bowled && x < lbw
      batsman.stats_batting[:wicket_taker] = "b #{bowler.name}"
      batsman.stats_batting[:howout] = "lbw"
      bowler.stats_bowling[:wickets] += 1
    elsif x >= lbw && x < caught_behind 
      batsman.stats_batting[:wicket_taker] = "b #{bowler.name}"
      batsman.stats_batting[:howout] = "c #{wicket_keeper.name}"
      bowler.stats_bowling[:wickets] += 1
    elsif x >= caught_behind && x < caught
      batsman.stats_batting[:wicket_taker] = "b #{bowler.name}"
      batsman.stats_batting[:howout] = "c #{fielder.name}"
      bowler.stats_bowling[:wickets] += 1
    elsif x >= caught && x < stumped
      batsman.stats_batting[:wicket_taker] = "b #{bowler.name}"
      batsman.stats_batting[:howout] = "st #{wicket_keeper.name}"
      bowler.stats_bowling[:wickets] += 1
    else x >= stumped 
      batsman.stats_batting[:wicket_taker] = "Run out"
      batsman.stats_batting[:howout] = "Run Out (#{fielder.name})"
  end
end