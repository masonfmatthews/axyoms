class Unit < ActiveRecord::Base
  has_many :unit_coverages

  validates :name, presence: true
  validates :order_number, presence: true, uniqueness: true

  def concept_uuids
    unit_coverages.map &:concept_uuid
  end

  def concepts
    Concept.find(concept_uuids)
  end
end
