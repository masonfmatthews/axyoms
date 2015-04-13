class Unit < ActiveRecord::Base
  include CoversConcepts
  has_many :coverages, dependent: :destroy,
      foreign_key: 'unit_id', class_name: "UnitCoverage"

  validates :name, presence: true
  validates :delivered_at, presence: true

  default_scope { order(:delivered_at) }

  def completed?
    delivered_at < Time.now
  end
end
