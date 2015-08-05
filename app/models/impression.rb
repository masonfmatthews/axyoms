class Impression < ActiveRecord::Base
  belongs_to :student
  belongs_to :assignment

  validates :student, presence: true
  validates :assignment, presence: true
  validates :concept_uuid, presence: true

  def concept
    Concept.where(uuid: concept_uuid).first
  end

  def description
    (positive ? "+" : "-") + "1 for " + concept.name + " on " + assignment.name
  end

  def description_with_student
    (positive ? "+" : "-") + "1 for " + concept.name + " by " + student.name
  end
end
