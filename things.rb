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
  attr_accessor :stats_batting, :stats_bowling, :stats_fielding
  attr_reader :name, :dob, :hand, :age, :type

  def initialize(name, dob, hand, type)
    @name = name
    @dob = dob
    @hand = hand
    @age = show_age(@dob)
    @type = type
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
    ((@stats_batting[:runs_scored].to_f / @stats_batting[:balls_faced].to_f) * 100).to_f.rnd_2
  end

  def economy
    (@stats_bowling[:runs_scored].to_f / @stats_bowling[:overs].to_f).to_f.rnd_2
  end
end