class Unit < ActiveRecord::Base
  include CoversConcepts
  has_many :coverages, foreign_key: 'unit_id', class_name: "UnitCoverage"

  validates :name, presence: true
  validates :delivered_at, presence: true

  def completed?
    delivered_at < Time.now
  end
end
