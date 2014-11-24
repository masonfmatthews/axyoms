class Unit < ActiveRecord::Base
  has_many :unit_coverages, dependent: :destroy

  validates :name, presence: true
  validates :delivered_at, presence: true

  def completed?
    delivered_at < Time.now
  end

  def concept_uuids
    unit_coverages.map &:concept_uuid
  end

  def concept_count
    unit_coverages.length
  end

  def concepts
    Concept.find(concept_uuids)
  end

  def add_concept(concept)
    unit_coverages << UnitCoverage.new(concept_uuid: concept.uuid)
  end

  def new_coverage(uuids)
    uuids.each do |uuid|
      self.unit_coverages << UnitCoverage.new(concept_uuid: uuid)
    end
  end

  def replace_coverage(uuids)
    self.unit_coverages = []
    new_coverage(uuids)
    save!
  end

  def coverage_hash
    coverage = Hash.new
    unit_coverages.each do |c|
      coverage[c.concept_uuid] = true
    end
    coverage
  end
end
