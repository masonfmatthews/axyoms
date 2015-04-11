class AssignmentCoverage < ActiveRecord::Base
  belongs_to :assignment

  validates :assignment, presence: true
  validates :concept_uuid, presence: true

  def concept
    Concept.where(uuid: concept_uuid).first
  end
end
