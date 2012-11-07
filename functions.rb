def read_in_csv_data(dest, csv_file_name)
  CSV.foreach(csv_file_name, headers: true) do |row|
    dest << Player.new(row["name"], row["dob"], row["hand"], row["type"])
  end
end

def random_run_engine
  x = rand(100)

  one_run       = 50
  two_runs      = 70
  three_runs    = 80
  four_runs     = 85
  six_runs      = 95

  if x >=0 && x < one_run
    return 0
  elsif x >= one_run && x < two_runs
    return 1
  elsif x >= two_runs && x < three_runs
    return 2
  elsif x >= three_runs && x < four_runs
    return 3
  elsif x >= four_runs && x < six_runs
    return 4
  elsif x >= six_runs && x < 100
    return 6
  end
end

def show_age(dob)
  now = Time.now
  true_dob = Date.parse dob
  now.year - true_dob.year
end

def coin_toss
  x = rand(100)
  if x % 2 == 0
    true 
  else
    false
  end
end

class Float

  def rnd_2
    (self*100).round / 100.0
  end
end