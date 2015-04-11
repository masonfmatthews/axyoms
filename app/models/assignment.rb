class Assignment < ActiveRecord::Base
  has_many :assignment_coverages, dependent: :destroy

  validates :name, presence: true

  def concept_uuids
    assignment_coverages.map &:concept_uuid
  end

  def concepts
    Concept.find(concept_uuids)
  end
end
