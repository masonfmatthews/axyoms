User.create!(name: "Mason",
             email: "mason@example.com",
             password: "password",
             password_confirmation: "password")

unit_hash = {"Week 1: M" => ["Procedural Programming", "Control Flow", "Variables"],
  "Week 1: T" => ["Procedural Programming", "Methods", "Arrays"],
  "Week 1: W" => ["Procedural Programming", "Arrays", "Hashes"],
  "Week 1: Th" => ["Object Oriented Programming", "Classes"],
  "Week 2: M" => ["Ruby", "Exceptions", "Testing"],
  "Week 2: T" => [],
  "Week 2: W" => [],
  "Week 2: Th" => [],
  "Week 3: M" => [],
  "Week 3: T" => [],
  "Week 3: W" => [],
  "Week 3: Th" => [],
  "Week 4: M" => [],
  "Week 4: T" => [],
  "Week 4: W" => [],
  "Week 4: Th" => [],
  "Week 5: M" => [],
  "Week 5: T" => [],
  "Week 5: W" => [],
  "Week 5: Th" => [],
  "Week 6: M" => [],
  "Week 6: T" => [],
  "Week 6: W" => [],
  "Week 6: Th" => [],
  "Week 7: M" => [],
  "Week 7: T" => [],
  "Week 7: W" => [],
  "Week 7: Th" => [],
  "Week 8: M" => [],
  "Week 8: T" => [],
  "Week 8: W" => [],
  "Week 8: Th" => [],
  "Week 9: M" => [],
  "Week 9: T" => [],
  "Week 9: W" => [],
  "Week 9: Th" => []
}

first_day = "2015-04-04".to_date
first_week = (0..3).to_a.map {|i| first_day + i.days}
all_days = (0..8).to_a.map {|j| first_week.map {|day| day + j.weeks}}
all_days.flatten!

unit_hash.each do |k, v|
  u = Unit.create!(name: k,
             delivered_at: all_days.shift)
  v.each do |concept_name|
    u.coverages.build(concept_uuid: Concept.where(name: concept_name).first.uuid)
  end
  u.save!
end

Reference.create!(description: "Google", uri: "http://google.com", concept_uuid: Concept.where(name: "Classes").first.uuid)

assignment_hashes = [
  { name: "Number Guessing Game",
    uri: "http://github.com",
    concepts: ["Methods", "Arrays"]},
  { name: "Battleship",
    uri: "http://github.com",
    concepts: ["Classes", "Testing", "Enumerable", "Inheritance"]}
]

assignment_hashes.each do |hash|
  a = Assignment.create!(name: hash[:name],
             uri: hash[:uri])
  hash[:concepts].each do |concept_name|
    a.coverages.build(concept_uuid: Concept.where(name: concept_name).first.uuid)
  end
  a.save!
end

student_names = ["JohnB", "Peter", "Scott", "Anna", "Danai", "Daisy", "Zack",
    "Aaron", "JohnG", "Cruz", "Turner", "Tamika", "Nathaniel"]
student_names.sort!

coverage_count = AssignmentCoverage.count
student_count = student_names.length
student_names.each do |n|
  s = Student.create!(name: n, email: "#{n}@#{n}.com")
  AssignmentCoverage.all.each do |ac|
    score = 1 + 3*(s.id.to_f/student_count) + 2*(ac.id.to_f/coverage_count)
    Score.create!(student: s,
        assignment_id: ac.assignment_id,
        concept_uuid: ac.concept_uuid,
        score: score)
  end
end
