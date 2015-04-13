class UnitCoverage < ActiveRecord::Base
  belongs_to :unit

  validates :unit, presence: true
  validates :concept_uuid, presence: true

  def self.completed_uuids
    datetime_field = Unit.arel_table[:delivered_at]
    joins(:unit)
      .where(datetime_field.lt(Time.now))
      .group(:concept_uuid)
      .select(:concept_uuid)
      .all.map &:concept_uuid
  end

  def concept
    Concept.where(uuid: concept_uuid).first
  end
end
