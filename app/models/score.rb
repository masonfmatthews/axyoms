class Score < ActiveRecord::Base
  belongs_to :student
  belongs_to :assignment

  validates :student, presence: true
  validates :assignment, presence: true
  validates :concept_uuid, presence: true
  validates :score, presence: true

  def concept
    Concept.where(uuid: concept_uuid).first
  end
end
