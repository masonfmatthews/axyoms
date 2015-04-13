class Assignment < ActiveRecord::Base
  include CoversConcepts
  has_many :coverages, dependent: :destroy,
      foreign_key: 'assignment_id', class_name: "AssignmentCoverage"
  has_many :scores, dependent: :restrict_with_error

  validates :name, presence: true
  validates :uri, presence: true, format: {with: /\Ahttps?:\/\//, message: "must start with http:// or https://"}

  def average_score
    (scores.reduce(0.0) {|sum, s| sum + s.score})/(scores.count)
  end

  def average_score_for_concept_uuid(uuid)
    concept_scores = scores.where(concept_uuid: uuid)
    (concept_scores.reduce(0.0) {|sum, s| sum + s.score})/(concept_scores.count)
  end
end
