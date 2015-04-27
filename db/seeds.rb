User.create!(name: "Mason",
             email: "mason@example.com",
             password: "password",
             password_confirmation: "password")

unit_hash = {"Week 1: M" => ["Procedural Programming", "Control Flow", "Variables"],
  "Week 1: T" => ["Procedural Programming", "Methods", "Arrays", "Git", "add, commit, push", "Commit Messages"],
  "Week 1: W" => ["Procedural Programming", "Arrays", "Hashes"],
  "Week 1: Th" => ["Object Oriented Programming", "Classes"],
  "Week 2: M" => ["Ruby", "Exceptions", "Testing", "Assertions", "Object Oriented Programming", "Inheritance", "Git"],
  "Week 2: T" => ["Ruby", "Modules", "Testing", "Assertions", "Inheritance", "Object Oriented Programming", "Composition"],
  "Week 2: W" => ["Ruby", "Regex", "Blocks", "Enumerable", "Testing", "Assertions"],
  "Week 2: Th" => ["Ruby", "Gems", "Testing", "TDD"],
  "Week 3: M" => ["Databases", "DB Design", "Migrations"],
  "Week 3: T" => ["Databases", "Migrations", "Unit Testing", "ActiveRecord"],
  "Week 3: W" => ["Databases", "Associations", "Validations", "Git", "branch", "merge"],
  "Week 3: Th" => ["APIs", "Consuming APIs", "Token Security", "Web Technologies", "HTTP", "JSON"],
  "Week 4: T" => ["APIs", "Producing APIs", "Web Technologies", "HTTP Verbs", "Rails", "MVC"],
  "Week 4: W" => ["Rails", "Controllers", "The Router", "Testing", "Controller Testing", "HTTP Verbs"],
  "Week 4: Th" => ["APIs", "Models", "Seeds", "Testing", "Fixtures"],
  "Week 4: F" => ["Rails", "Environments", "Deployment"],
  "Week 5: M" => ["Web Technologies", "HTML", "CSS"],
  "Week 5: T" => ["Views", "ERB", "Web Technologies", "HTML Forms", "Git", "reset", "filter-branch"],
  "Week 5: W" => ["Web Technologies", "REST", "Rails", "Scaffold", "Testing", "Integration Testing"],
  "Week 5: Th" => ["Views", "Helpers", "Partials"],
  "Week 6: M" => ["Rails", "Asset Pipeline", "Views", "SCSS/Bootstrap"],
  "Week 6: T" => ["Rails", "Session", "Web App Patterns", "Authentication"],
  "Week 6: W" => ["Rails", "Session", "Models", "Scope", "Web App Patterns", "Authentication"],
  "Week 6: Th" => ["Models", "Nested Attributes"],
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

Reference.create!(description: "Enumerable on APIdock", uri: "http://apidock.com/ruby/Enumerable", concept_uuid: Concept.where(name: "Enumerable").first.uuid)
Reference.create!(description: 'Composition in "Ruby the Hard Way"', uri: "http://learnrubythehardway.org/book/ex44.html", concept_uuid: Concept.where(name: "Composition").first.uuid)

assignment_hashes = [
  { name: "User Input Statistics",
    uri: "https://github.com/tiyd-rails-2015-05/input_statistics",
    concepts: ["Control Flow", "Variables"]},
  { name: "Number Guessing Game",
    uri: "https://github.com/tiyd-rails-2015-05/number_guessing",
    concepts: ["Methods", "Arrays", "add, commit, push"]},
  { name: "Blackjack Advisor",
    uri: "https://github.com/tiyd-rails-2015-05/blackjack_advisor",
    concepts: ["Methods", "Arrays"]},
  { name: "Currency Converter",
    uri: "https://github.com/tiyd-rails-2015-05/currency_converter_project",
    concepts: ["Methods", "Arrays"]},
  { name: "Battleship Day 1",
    uri: "https://github.com/tiyd-rails-2015-05/battleship",
    concepts: ["Classes", "Assertions", "Inheritance"]},
  { name: "Battleship Day 2",
    uri: "https://github.com/tiyd-rails-2015-05/battleship",
    concepts: ["Classes", "Assertions", "Composition"]},
  { name: "Battleship Day 3",
    uri: "https://github.com/tiyd-rails-2015-05/battleship",
    concepts: ["Classes", "Assertions", "Enumerable", "Regex"]},
  { name: "Employee Reviews",
    uri: "https://github.com/tiyd-rails-2015-05/employee_reviews_project",
    concepts: ["Composition", "TDD", "Enumerable", "Regex", "Blocks"]},
  { name: "Time Entry Data Structure",
    uri: "https://github.com/tiyd-rails-2015-05/time_entry_data_structure",
    concepts: ["DB Design", "Migrations"]},
  { name: "Employee Reviews w/ DB",
    uri: "https://github.com/tiyd-rails-2015-05/employee_reviews_with_db",
    concepts: ["Migrations", "Unit Testing", "ActiveRecord"]},
  { name: "Legacy Associations",
    uri: "https://github.com/tiyd-rails-2015-05/legacy_associations_and_validations",
    concepts: ["Associations", "Validations", "branch", "merge"]},
  { name: "Weather Report",
    uri: "https://github.com/tiyd-rails-2015-05/weather_report",
    concepts: ["Consuming APIs", "Token Security", "HTTP", "JSON"]},
  { name: "Voting API",
    uri: "https://github.com/tiyd-rails-2015-05/voting_api",
    concepts: ["Producing APIs", "HTTP Verbs", "MVC", "Controllers", "The Router", "Controller Testing"]},
  { name: "Build Your Own API",
    uri: "https://github.com/tiyd-rails-2015-05/novel_api",
    concepts: ["Producing APIs", "Consuming APIs", "JSON", "HTTP Verbs", "Seeds", "Fixtures", "Environments", "Deployment"]},
  { name: "CSS Reverse Engineering",
    uri: "https://github.com/tiyd-rails-2015-05/css_reverse_engineering",
    concepts: ["HTML", "CSS"]},
  { name: "Recreate GitHub Profile",
    uri: "https://github.com/tiyd-rails-2015-05/github_profile",
    concepts: ["ERB", "HTML Forms", "Git", "reset", "filter-branch"]},
  { name: "Wallet",
    uri: "https://github.com/tiyd-rails-2015-05/wallet",
    concepts: ["REST", "Scaffold", "Integration Testing"]},
  { name: "Health Tracker",
    uri: "https://github.com/tiyd-rails-2015-05/health_tracker",
    concepts: ["MVC", "REST", "The Router", "ERB", "Testing", "HTML", "CSS"]},
  { name: "Restaurant Menu",
    uri: "https://github.com/tiyd-rails-2015-05/restaurant_menu",
    concepts: ["Asset Pipeline", "Deployments", "SCSS/Bootstrap"]},
  { name: "Teacherbook",
    uri: "https://github.com/tiyd-rails-2015-05/teacherbook",
    concepts: ["Authentication", "Session"]},
  { name: "Gradebook",
    uri: "https://github.com/tiyd-rails-2015-05/gradebook",
    concepts: ["Session", "Authorization", "Scope"]},
  { name: "Survey Opossum",
    uri: "https://github.com/tiyd-rails-2015-05/survey_opossum",
    concepts: ["ERB", "Nested Attributes", "Authentication", "REST", "Deployment", "Testing"]}
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
    "Aaron", "JohnG", "Cruz", "Turner", "Tamika", "Nathaniel", "Jennifer", "Joe"]

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
