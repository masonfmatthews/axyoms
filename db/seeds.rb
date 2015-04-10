User.create!(name: "Mason",
             email: "mason@example.com",
             password: "password",
             password_confirmation: "password")

unit_hash = {"Wk1: Mon" => ["Control Flow", "Variables"],
  "Wk1: Tue" => ["Methods", "Arrays"],
  "Wk1: Wed" => ["Arrays", "Hashes"],
  "Wk1: Thu" => ["Classes"],
  "Wk2: Mon" => ["Exceptions", "Testing"],
  "Wk2: Tue" => ["Methods", "Arrays"],
  "Wk2: Wed" => [],
  "Wk2: Thu" => [],
  "Wk3: Mon" => [],
  "Wk3: Tue" => [],
  "Wk3: Wed" => [],
  "Wk3: Thu" => [],
  "Wk4: Mon" => [],
  "Wk4: Tue" => [],
  "Wk4: Wed" => [],
  "Wk4: Thu" => [],
  "Wk5: Mon" => [],
  "Wk5: Tue" => [],
  "Wk5: Wed" => [],
  "Wk5: Thu" => [],
  "Wk6: Mon" => [],
  "Wk6: Tue" => [],
  "Wk6: Wed" => [],
  "Wk6: Thu" => [],
  "Wk7: Mon" => [],
  "Wk7: Tue" => [],
  "Wk7: Wed" => [],
  "Wk7: Thu" => [],
  "Wk8: Mon" => [],
  "Wk8: Tue" => [],
  "Wk8: Wed" => [],
  "Wk8: Thu" => [],
  "Wk9: Mon" => [],
  "Wk9: Tue" => [],
  "Wk9: Wed" => [],
  "Wk9: Thu" => []
}

first_day = "2015-04-04".to_date
first_week = (0..3).to_a.map {|i| first_day + i.days}
all_days = (0..8).to_a.map {|j| first_week.map {|day| day + j.weeks}}
all_days.flatten!

unit_hash.each do |k, v|
  u = Unit.new(name: k,
             delivered_at: all_days.shift)
  v.each do |concept_name|
    u.unit_coverages << UnitCoverage.new(concept_uuid: Concept.where(name: concept_name).first.uuid)
  end
  u.save!
end

student_names = ["JohnB", "Peter", "Scott", "Anna", "Danai", "Daisy", "Zack",
    "Aaron", "JohnG", "Cruz", "Turner", "Tamika", "Nathaniel"]

student_names.each do |n|
  Student.create!(name: n, email: "#{n}@#{n}.com")
end
