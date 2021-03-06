User.create!(name: "User",
             email: "user@example.com",
             password: "password",
             password_confirmation: "password")

unit_hash = {"Week 1: Day 1" => ["Procedural Programming", "Control Flow", "Variables"],
  "Week 1: Day 2" => ["Methods", "Arrays", "Git", "init, add, commit, push", "Commit Messages"],
  "Week 1: Day 3" => ["Arrays", "Hashes"],
  "Week 1: Day 4" => ["Object Oriented Programming", "Classes"],
  "Week 2: Day 1" => ["Ruby", "Exceptions", "Testing", "Inheritance", "fork, clone, pull", ".git, .gitignore"],
  "Week 2: Day 2" => ["Modules", "Composition"],
  "Week 2: Day 3" => ["Regular Expressions", "Blocks", "Enumerable"],
  "Week 2: Day 4" => ["Gems", "TDD"],
  "Week 3: Day 1" => ["Databases", "DB Design", "Migrations", "ActiveRecord"],
  "Week 3: Day 2" => ["SQL", "Many-to-many"],
  "Week 3: Day 3" => ["Models", "Unit Testing"],
  "Week 3: Day 4" => ["Associations", "Validations", "branch, merge"],
  "Week 4: Day 1" => ["APIs", "Consuming APIs", "Web Technologies", "HTTP", "JSON"],
  "Week 4: Day 2" => ["Producing APIs", "HTTP Verbs", "Rails", "MVC"],
  "Week 4: Day 3" => ["Controllers", "Routing", "Controller Testing", "HTTP Verbs"],
  "Week 4: Day 4" => ["Seeds", "Fixtures"],
  "Week 5: Day 1" => ["HTML", "CSS"],
  "Week 5: Day 2" => ["Views", "ERB", "HTML Forms"],
  "Week 5: Day 3" => ["REST", "Scaffold"],
  "Week 5: Day 4" => ["Helpers", "Partials", "Deployment", "Workflows"],
  "Week 6: Day 1" => ["Asset Pipeline", "SCSS"],
  "Week 6: Day 2" => ["Session", "Web App Patterns", "Authentication"],
  "Week 6: Day 3" => ["Integration Testing", "Authorization"],
  "Week 6: Day 4" => ["Nested Attributes"],
  "Week 7: Day 1" => ["JavaScript", "DOM Manipulation"],
  "Week 7: Day 2" => ["jQuery", "Unobtrusive JavaScript"],
  "Week 7: Day 3" => ["AJAX"],
  "Week 7: Day 4" => [],
  "Week 8: Day 1" => ["Indices", "Efficiency", "Query Optimizations", "Runtime Optimizations", "Memory Optimizations"],
  "Week 8: Day 2" => ["Background Processing"],
  "Week 8: Day 3" => ["Mailers"],
  "Week 8: Day 4" => ["File Uploads"],
  "Week 9: Day 1" => ["oAuth", "DevOps"],
  "Week 9: Day 2" => ["d3.js"],
  "Week 9: Day 3" => [],
  "Week 9: Day 4" => []
}

first_day = "2015-08-31".to_date
first_week = (0..3).to_a.map {|i| first_day + i.days}
all_days = (0..8).to_a.map {|j| first_week.map {|day| day + j.weeks}}
all_days.flatten!

unit_hash.each do |k, v|
  u = Unit.create!(name: k,
             delivered_at: all_days.shift)
  v.each do |concept_name|
    puts concept_name
    u.coverages.build(concept_uuid: Concept.where(name: concept_name).first.uuid)
  end
  u.save!
end

assignment_hashes = [
  { name: "User Input Statistics",
    uri: "https://github.com/tiyd-rails-2015-08/input_statistics",
    concepts: ["Control Flow", "Variables"]},
  { name: "Number Guessing Game",
    uri: "https://github.com/tiyd-rails-2015-08/number_guessing",
    concepts: ["Methods", "Arrays", "init, add, commit, push"]},
  { name: "Blackjack Advisor",
    uri: "https://github.com/tiyd-rails-2015-08/blackjack_advisor",
    concepts: ["Methods", "Arrays", "Hashes"]},
  { name: "Currency Converter",
    uri: "https://github.com/tiyd-rails-2015-08/currency_converter_project",
    concepts: ["Methods", "Arrays", "Hashes", "Exceptions"]},
  { name: "Battleship",
    uri: "https://github.com/tiyd-rails-2015-08/battleship",
    concepts: ["Classes", "Testing", "Inheritance", "Composition", "Enumerable", "Regular Expressions"]},
  { name: "Employee Reviews",
    uri: "https://github.com/tiyd-rails-2015-08/employee_reviews_project",
    concepts: ["Composition", "TDD", "Enumerable", "Regular Expressions", "Blocks"]},
  { name: "Time Entry Data Structure",
    uri: "https://github.com/tiyd-rails-2015-08/time_entry_data_structure",
    concepts: ["DB Design", "Migrations"]},
  { name: "Time Entry SQL Practice",
    uri: "https://github.com/tiyd-rails-2015-08/time_entry_sql_practice",
    concepts: ["SQL"]},
  { name: "Employee Reviews w/ DB",
    uri: "https://github.com/tiyd-rails-2015-08/employee_reviews_with_db",
    concepts: ["Migrations", "Unit Testing", "Models"]},
  { name: "Legacy Associations",
    uri: "https://github.com/tiyd-rails-2015-08/legacy_associations_and_validations",
    concepts: ["Associations", "Validations", "branch, merge"]},
  { name: "Weather Report",
    uri: "https://github.com/tiyd-rails-2015-08/weather_report",
    concepts: ["Consuming APIs", "HTTP", "JSON"]},
  { name: "Voting API",
    uri: "https://github.com/tiyd-rails-2015-08/voting_api",
    concepts: ["Producing APIs", "HTTP Verbs", "MVC", "Controllers", "Routing", "Controller Testing"]},
  { name: "Build Your Own API",
    uri: "https://github.com/tiyd-rails-2015-08/build_your_own_api",
    concepts: ["Producing APIs", "Consuming APIs", "JSON", "HTTP Verbs", "Seeds", "Fixtures"]},
  { name: "CSS Reverse Engineering",
    uri: "https://github.com/tiyd-rails-2015-08/css_reverse_engineering",
    concepts: ["HTML", "CSS"]},
  { name: "Recreate GitHub Profile",
    uri: "https://github.com/tiyd-rails-2015-08/github_profile",
    concepts: ["ERB", "HTML Forms"]},
  { name: "Wallet",
    uri: "https://github.com/tiyd-rails-2015-08/wallet",
    concepts: ["REST", "Scaffold", "Integration Testing"]},
  { name: "Health Tracker",
    uri: "https://github.com/tiyd-rails-2015-08/health_tracker",
    concepts: ["MVC", "REST", "Routing", "ERB", "Testing", "HTML", "CSS", "Helpers", "Partials"]},
  { name: "Restaurant Menu",
    uri: "https://github.com/tiyd-rails-2015-08/restaurant_menu",
    concepts: ["Asset Pipeline", "Deployment", "SCSS"]},
  { name: "Gradebook",
    uri: "https://github.com/tiyd-rails-2015-08/gradebook",
    concepts: ["Session", "Authentication", "Authorization"]},
  { name: "Survey Opossum",
    uri: "https://github.com/tiyd-rails-2015-08/survey_opossum",
    concepts: ["ERB", "Nested Attributes", "Authentication", "REST", "Deployment", "Testing"]},
  { name: "Add JavaScript",
    uri: "https://github.com/tiyd-rails-2015-08/add_javascript",
    concepts: ["DOM Manipulation"]},
  { name: "Add jQuery",
    uri: "https://github.com/tiyd-rails-2015-08/add_jquery",
    concepts: ["DOM Manipulation", "jQuery"]},
  { name: "Auction Site",
    uri: "https://github.com/tiyd-rails-2015-08/auction_ajax",
    concepts: ["DOM Manipulation", "jQuery", "AJAX"]},
  { name: "Todo App",
    uri: "https://github.com/tiyd-rails-2015-08/todo_app",
    concepts: ["jQuery", "AJAX", "Asset Pipeline"]},
  { name: "Database Optimizations",
    uri: "https://github.com/tiyd-rails-2015-08/database_optimizations",
    concepts: ["SQL", "Indices", "AREL"]},
  { name: "Data File Import",
    uri: "https://github.com/tiyd-rails-2015-08/data_file_import",
    concepts: ["Background Processing", "File Uploads"]},
  { name: "Delayed Mailer",
    uri: "https://github.com/tiyd-rails-2015-08/delayed_mailer",
    concepts: ["Mailers", "Background Processing"]},
  { name: "Gradebook Tickets",
    uri: "https://github.com/tiyd-rails-2015-08/gradebook_tickets",
    concepts: ["Rails", "Web App Patterns"]},

  { name: "Challenge: If (FizzBuzz)",
    uri: "https://github.com/rails_assignments/tree/master/challenges/if_challenge.rb",
    concepts: ["Control Flow", "Methods"]},
  { name: "Challenge: String Split",
    uri: "https://github.com/rails_assignments/tree/master/challenges/string_split_challenge.rb",
    concepts: ["Control Flow", "Methods"]},
  { name: "Challenge: Arrays and Hashes",
    uri: "https://github.com/rails_assignments/tree/master/challenges/array_and_hash_challenge.rb",
    concepts: ["Arrays", "Hashes"]},
  { name: "Challenge: Classes",
    uri: "https://github.com/rails_assignments/tree/master/challenges/classes_challenge.rb",
    concepts: ["Classes"]},
  { name: "Challenge: Inheritance",
    uri: "https://github.com/rails_assignments/tree/master/challenges/inheritance_challenge.rb",
    concepts: ["Inheritance"]},
  { name: "Challenge: Composition",
    uri: "https://github.com/rails_assignments/tree/master/challenges/composition_challenge.rb",
    concepts: ["Composition"]},
  { name: "Challenge: Enumerable",
    uri: "https://github.com/rails_assignments/tree/master/challenges/enumerable_challenge.rb",
    concepts: ["Enumerable"]},
  { name: "Challenge: Include",
    uri: "https://github.com/rails_assignments/tree/master/challenges/include_challenge.rb",
    concepts: ["Modules"]},
  { name: "Challenge: Discuss Ruby",
    uri: "https://github.com/rails_assignments/tree/master/challenges/discuss_ruby.md",
    concepts: ["Ruby"]},
  { name: "Challenge: Discuss HTTP",
    uri: "https://github.com/rails_assignments/tree/master/challenges/discuss_http.md",
    concepts: ["HTTP"]},
  { name: "Challenge: Rails Router",
    uri: "https://github.com/rails_assignments/tree/master/challenges/rails_router.md",
    concepts: ["Routing"]},
  { name: "Challenge: Rails Environments",
    uri: "https://github.com/rails_assignments/tree/master/challenges/rails_environments.md",
    concepts: ["Deployment"]},
  { name: "Challenge: Rails ActiveRecord",
    uri: "https://github.com/rails_assignments/tree/master/challenges/rails_active_record.md",
    concepts: ["ActiveRecord"]},
  { name: "Challenge: Rails form_for",
    uri: "https://github.com/rails_assignments/tree/master/challenges/rails_form_for.md",
    concepts: ["HTML Forms"]},
  { name: "Challenge: Rails and REST",
    uri: "https://github.com/rails_assignments/tree/master/challenges/rails_rest.md",
    concepts: ["REST"]},
  { name: "Challenge: Rails Partials",
    uri: "https://github.com/rails_assignments/tree/master/challenges/rails_partials.md",
    concepts: ["Partials"]},
  { name: "Challenge: Rails Helpers",
    uri: "https://github.com/rails_assignments/tree/master/challenges/rails_helpers.md",
    concepts: ["Helpers"]},
  { name: "Challenge: Rails Session",
    uri: "https://github.com/rails_assignments/tree/master/challenges/rails_session.md",
    concepts: ["Session"]},
  { name: "Challenge: Discuss Git Messes",
    uri: "https://github.com/rails_assignments/tree/master/challenges/discuss_git_messes.md",
    concepts: ["Git", "reset, filter-branch"]},
  { name: "Challenge: Primes",
    uri: "https://github.com/rails_assignments/tree/master/challenges/hard_primes_challenge.rb",
    concepts: ["Procedural Programming"]},
  { name: "Challenge: Double Loop",
    uri: "https://github.com/rails_assignments/tree/master/challenges/double_loop_challenge.rb",
    concepts: ["Procedural Programming"]},
  { name: "Challenge: Rails and JavaScript",
    uri: "https://github.com/rails_assignments/tree/master/challenges/rails_javascript.md",
    concepts: ["DOM Manipulation"]},
  { name: "Challenge: Rails and jQuery",
    uri: "https://github.com/rails_assignments/tree/master/challenges/rails_jquery.md",
    concepts: ["jQuery"]},
  { name: "Challenge: Discuss Rails",
    uri: "https://github.com/rails_assignments/tree/master/challenges/discuss_rails.md",
    concepts: ["Rails"]},
  { name: "Challenge: Discuss Supporting Tech",
    uri: "https://github.com/rails_assignments/tree/master/challenges/discuss_supporting_technologies.md",
    concepts: ["Web App Patterns"]},
  { name: "Challenge: Discuss Development",
    uri: "https://github.com/rails_assignments/tree/master/challenges/discuss_development.md",
    concepts: ["Web App Patterns"]}
]

assignment_hashes.each do |hash|
  a = Assignment.create!(name: hash[:name],
             uri: hash[:uri])
  hash[:concepts].each do |concept_name|
    puts concept_name
    a.coverages.build(concept_uuid: Concept.where(name: concept_name).first.uuid)
  end
  a.save!
end

s = Student.create!(name: "Student", email: "student@example.com")
