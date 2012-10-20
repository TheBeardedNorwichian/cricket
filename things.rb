require 'date'
require 'csv'

class Ground < GameComponents

  def initialize(name='Test Ground', county='Norfolk',country='England',size='Medium',capacity=2000,home_team='Norfolk CC')
    @name = name
    @county = county
    @country = country
    @size = size
    @capacity = capacity
    @home_team = home_team
  end
end

class Team < GameComponents
  attr_reader :team_name, :country, :ground, :players, :team

  def initialize(data, team_name="Norfolk CC", country ="England", county="Norfolk",ground="Lords")
    @team_name = team_name
    @players = Array.new 
    @country = country
    @county = county
    @ground = ground
    @data = data
    load_data
  end

  def load_data
    read_in_csv_data(@players, @data)
  end
end


class Player < GameComponents
  attr_reader :name, :dob, :hand, :age, :type

  def initialize(name, dob, hand, type)
    @name = name
    @dob = dob
    @hand = hand
    @age = show_age(@dob)
    @type = type
  end

  def hit
  end

  def score
  end

  def state
  end

  def bowl
  end
end

class Over < GameComponents
  attr_reader :balls, :o_runs, :wickets, :bowler, :balls, :over_id, :delivery

  def initialize(bowler, over_id)
    @balls = []
    @o_runs = 0
    @wickets = 0
    @bowler = bowler
    @over_id = over_id
    @delivery
    run_over
  end

  def run_over
    ball_in_over = 1
    while @balls.length < 6 do 
      @ball = Ball.new(ball_in_over)
      @balls << @ball 
      ball_in_over += 1
      runs_in_over
    end
  end

  def runs_in_over
    @o_runs += @ball.b_runs
  end


end

class Ball < GameComponents
  attr_reader :pitch, :length, :speed, :spin, :seam, :status, :ball_in_over, :b_runs, :b_desc
  def initialize(ball_in_over)
    @pitch = sprintf '%02d', random
    @length = sprintf '%02d', random
    @speed = sprintf '%02d', random
    @spin = sprintf '%02d', random
    @seam = sprintf '%02d', random
    @ball_in_over = ball_in_over
    @b_runs = random_run_engine
    @b_desc
  end

  def random
    rand(100)
  end
end