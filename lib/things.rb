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
    CSV.foreach(csv_file_name, headers: false) do |row|
      dest << Player.new(row[0].strip, row[1].strip, row[2].strip, row[3].strip, row[4].strip, row[5].strip)
    end
  end

end