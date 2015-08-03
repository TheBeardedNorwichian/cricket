class Match < GameComponents
  attr_accessor :team1, :team2

  def initialize(type)
    @match_hash       = {}
    @team1            = Team.new('./lib/Teams/Australia.csv',"Australia")
    @team2            = Team.new('./lib/Teams/England.csv',"England")
    @ground           = Ground.new()
    @score            = {}
    @type             = type
    @total_overs      = 0
    @no_innings       = 0
    @length           = 0 
    game_type(type)
  end

  def game_type(type)
    case type
      when "t20"
        puts "You have selected T20"
        @total_overs = 20
        @no_innings = 2
        @length = 1
      when "one_day"
        puts "You have selected One Day International"
        @total_overs = 50
        @no_innings = 2
        @length = 1
      when "test"
        puts "You have selected Test Match"
        @total_overs = 999
        @no_innings = 4
        @length = 5
      else
        puts "You didn't select a valid game type"
    end
  end

  def go
    puts "There are potentially #{@total_overs == 999 ? "unlimited" : @total_overs} overs with #{@no_innings.to_s} innings per team in #{@length == 1 ? "a single day." : "#{@length} days." }"
    flip_coin
    @no_innings.times do |x|
      innings = Innings.new(x, @batting_team, @fielding_team, @total_overs)
      innings.run_innings
      puts innings.score
      change_of_innings
    end
  end

  def flip_coin
    x = rand
    if x >= 0.5
      @batting_team = @team1
      @fielding_team = @team2 
      puts "#{@team1.team_name} won the toss and decided to bat."
    else
      @batting_team = @team2
      @fielding_team = @team1 
      puts "#{@team2.team_name} won the toss and decided to bat."
    end
  end

  def change_of_innings
    x = @batting_team
    y = @fielding_team
    @fielding_team = x
    @batting_team = y
  end

  def check_winner
    if @team1_total > @team2_total
      team_win = "# #{@team1.team_name} beat #{@team2.team_name} by #{win_score(@first_innings.score, @second_innings.score)} runs. #"
    else
      team_win ="# #{@team2.team_name} beat #{@team1.team_name} by #{10 - @second_innings.wickets} wickets. #"
    end
    puts "#" * (team_win.length)
    puts team_win
    puts "#" * (team_win.length)
  end

  def win_score(score1, score2)
    return score1 - score2
  end

  def balls_remaining
    (@total_overs * 6)
  end

end
