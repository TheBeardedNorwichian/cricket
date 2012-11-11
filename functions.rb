def read_in_csv_data(dest, csv_file_name)
  CSV.foreach(csv_file_name, headers: true) do |row|
    dest << Player.new(row["name"], row["dob"], row["hand"], row["type"], row["bat_var"])
  end
end

def random_run_engine(bat_var)
  y = rand(100)
  x = y + bat_var

  one_run       = 70
  two_runs      = 85
  three_runs    = 91
  four_runs     = 94
  six_runs      = 99

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
  elsif x >= six_runs
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

def pad_l(string, size)
  pad = size - string.to_s.length
  return "#{string}" + " " * pad
end

def pad_r(string, size)
  pad = size - string.to_s.length
  return " " * pad + "#{string}"
end

class Float

  def rnd_2
    (self*100).round / 100.0
  end
end
