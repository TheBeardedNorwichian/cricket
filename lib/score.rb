class Score

  class << self

    def initialize
      @@score = 0
    end

    def add_runs(score, runs)
      puts "it is working"
      score = score + runs
    end

    def score
      @@score
    end

    def new_score(score)
      @@score = @@score + score
    end

  end
end