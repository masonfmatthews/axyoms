class Unit < ActiveRecord::Base
  include CoversConcepts
  has_many :coverages, foreign_key: 'unit_id', class_name: "UnitCoverage"

  validates :name, presence: true
  validates :delivered_at, presence: true

  after_save :reset_cache

  def reset_cache
    GraphCache.get.cache_unit_ids!
  end

  def completed?
    delivered_at < Time.now
  end
end
