class Unit < ActiveRecord::Base
  has_many :unit_coverages

  validates :name, presence: true
  validates :delivered_at, presence: true

  def concept_uuids
    unit_coverages.map &:concept_uuid
  end

  def concepts
    Concept.find(concept_uuids)
  end

  def add_concept(concept)
    unit_coverages << UnitCoverage.new(concept_uuid: concept.uuid)
  end
end
