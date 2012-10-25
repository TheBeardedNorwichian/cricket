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
  attr_accessor :stats
  attr_reader :name, :dob, :hand, :age, :type

  def initialize(name, dob, hand, type)
    @name = name
    @dob = dob
    @hand = hand
    @age = show_age(@dob)
    @type = type
    @stats = {
        balls_faced:  0, 
        dot_balls:    0,
        runs_scored:  0,
        fours_hit:    0,
        sixes_hit:    0} 
  end
end

class Bowler < Player
end

class Batter < Player
end

class Fielder < Player
end