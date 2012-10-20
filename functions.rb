def read_in_csv_data(dest, csv_file_name)
  CSV.foreach(csv_file_name, headers: true) do |row|
    dest << Player.new(row["name"], row["dob"], row["hand"], row["type"])
  end
end

def random_run_engine
  x = rand(100)
  if x >=0 && x < 60
    return 0
  elsif x >= 60 && x < 80
    return 1
  elsif x >= 80 && x < 87
    return 2
  elsif x >= 87 && x < 92
    return 3
  elsif x >= 92 && x < 98
    return 4
  elsif x >= 97 && x < 100
    return 6
  end
end

def show_age(dob)
  now = Time.now
  true_dob = Date.parse dob
  now.year - true_dob.year
end

class Float

  def rnd_2
    (self*100).round / 100.0
  end
end