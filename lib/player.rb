class Player < GameComponents
  attr_accessor :stats_batting, :stats_bowling, :stats_fielding, :energy, :hit, :ball
  attr_reader :name, :dob, :hand, :age, :type, :batting_attr, :enery, :b_runs

  def initialize(name, dob, hand, type, bat_var, bowl_var)
    @name = name
    @dob = dob
    @hand = hand
    @age = show_age(@dob)
    @type = type
    @energy = 100
    @batting_attr = {
        batting:      bat_var.to_i
    }
    @bowling_attr = {
        bowling:      bowl_var.to_i
    }
    @stats_batting = {}
    @stats_bowling = {}
    @stats_fielding = {}
  end

  def strike_rate(innings)
    ((@stats_batting[innings][:runs_scored].to_f / @stats_batting[innings][:balls_faced].to_f) * 100).rnd_2 
  end

  def economy(innings)
    (@stats_bowling[innings][:runs_scored].to_f / @stats_bowling[innings][:overs].to_f).to_f.rnd_2
  end


  def wicket(innings)
    @stats_batting[innings][:out] = true
    @b_runs = 0
  end

#--------------
#bowling actions
#--------------
  def bowl(innings)
    #needs developing
    #no ball?
    @energy = @energy - 1
    @stats_bowling[innings][:deliveries] += 1
    return @ball = {
      length:    rand(100),
      pitch:     rand(100), 
      speed:     rand(100)
    }
  end

#--------------
#batting actions
#--------------
#need to think about wicket taking
  def play(ball, innings)
    @ball_sum = ball[:length] + ball[:pitch] + ball[:speed]
    if @ball_sum > 50
      hit(innings)
      if @b_runs == 0
        @stats_batting[innings][:dot_balls] += 1
      end
    else
      wicket(innings)
    end
  end

  def hit(innings)
    #catch / caught behind?
    #if hit - run or not?  means run out possible
    @b_runs = random_run_engine(@batting_attr[:batting])
    if @b_runs > 0
      @stats_batting[innings][:runs_scored] += @b_runs
      if @b_runs == 4
        @stats_batting[innings][:fours_hit] += 1
      end
      if @b_runs == 6
        @stats_batting[innings][:sixes_hit] += 1
      end
    end
  end

end

