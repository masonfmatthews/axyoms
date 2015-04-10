User.create!(name: "Mason",
             email: "mason@example.com",
             password: "password",
             password_confirmation: "password")

unit_hash = {"Programming Languages" => ["Control Flow", "Variables"]}

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
