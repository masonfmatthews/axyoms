class UnitCoverage < ActiveRecord::Base
  belongs_to :unit

  validates :unit, presence: true
  validates :concept_uuid, presence: true

  def concept
    Concept.where(uuid: concept_uuid).first
  end
end
