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