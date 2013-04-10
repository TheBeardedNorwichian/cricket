class Player < GameComponents
  attr_accessor :stats_batting, :stats_bowling, :stats_fielding, :energy, :hit, :ball
  attr_reader :name, :dob, :hand, :age, :type, :batting_attr, :enery, :b_runs

  def initialize(name, dob, hand, type, bat_var)
    @name = name
    @dob = dob
    @hand = hand
    @age = show_age(@dob)
    @type = type
    @energy = 100
    @batting_attr = {
        batting:      bat_var.to_i
    }
    @stats_batting = {
        batted:       false,
        balls_faced:  0, 
        dot_balls:    0,  
        runs_scored:  0,
        fours_hit:    0,
        sixes_hit:    0,
        out:          false,
        wicket_taker: "Not Out"
      }
    @stats_bowling = {
        overs:        0,
        deliveries:   0, 
        maidens:      0,
        runs_scored:  0,
        wickets:      0,
        wides:        0,
        no_balls:     0,
        runs:         0
      }
    @stats_fielding = {
        catches:      0,
        stumpings:    0,
        run_outs:     0
      }
  end

  def strike_rate
    ((@stats_batting[:runs_scored].to_f / @stats_batting[:balls_faced].to_f) * 100).rnd_2 
  end

  def economy
    (@stats_bowling[:runs_scored].to_f / @stats_bowling[:overs].to_f).to_f.rnd_2
  end


#--------------
#bowling actions
#--------------
  def bowl
    #needs developing
    #no ball?
    @energy = @energy - 1
    @stats_bowling[:deliveries] += 1
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
  def play(ball)
    @ball_sum = ball[:length] + ball[:pitch] + ball[:speed]
    if @ball_sum > 50
      hit
      if @b_runs == 0
        @stats_batting[:dot_balls] += 1
      end
    else
      #hits stumps or not? below is temporary
      @stats_batting[:out] = true
      @b_runs = 0
    end
  end

  def hit
    #catch / caught behind?
    #if hit - run or not?  means run out possible
    @b_runs = random_run_engine(@batting_attr[:batting])
    if @b_runs > 0
      @stats_batting[:runs_scored] += @b_runs
      if @b_runs == 4
        @stats_batting[:fours_hit] += 1
      end
      if @b_runs == 6
        @stats_batting[:sixes_hit] += 1
      end
    end
  end

end