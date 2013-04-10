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
  attr_accessor :score
  attr_reader :team_name, :country, :ground, :players, :team

  def initialize(data, team_name, country ="England", county="Norfolk",ground="Lords")
    @team_name = team_name
    @players = Array.new 
    @country = country
    @county = county
    @ground = ground
    @data = data
    load_data
    @score = {}
  end

  def load_data
    read_in_csv_data(@players, @data)
  end

  def read_in_csv_data(dest, csv_file_name)
    CSV.foreach(csv_file_name, headers: true) do |row|
      dest << Player.new(row["name"], row["dob"], row["hand"], row["type"], row["bat_var"])
    end
  end

end


class Player < GameComponents
  attr_accessor :stats_batting, :stats_bowling, :stats_fielding, :bowl_ball, :energy, :hit, :ball
  attr_reader :name, :dob, :hand, :age, :type, :batting_attr, :enery, :b_runs

  def initialize(name, dob, hand, type, bat_var)
    @name = name
    @dob = dob
    @hand = hand
    @age = show_age(@dob)
    @type = type
    @energy = 100
    @ball = {}
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

  def bowl
    #needs developing
    @ball = {
      length:    rand(100),
      pitch:     rand(100), 
      speed:     rand(100)
    }
    @energy = @energy - 1
  end

  def hit
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