class Assignment < ActiveRecord::Base
  include CoversConcepts
  has_many :coverages, dependent: :destroy,
      foreign_key: 'assignment_id', class_name: "AssignmentCoverage"
  has_many :scores, dependent: :restrict_with_error
  has_many :impressions, dependent: :restrict_with_error

  validates :name, presence: true
  validates :uri, presence: true, format: {with: /\Ahttps?:\/\//, message: "must start with http:// or https://"}

  default_scope { order(:created_at) }

  def average_score(student = nil)
    pertinent_scores = (student ? scores.where(student_id: student.id) : scores)
    return nil if pertinent_scores.blank?
    impression_score(student) + (pertinent_scores.reduce(0.0) {|sum, s| sum + s.score})/(pertinent_scores.count)
  end

  def impression_score(student)
    if student
      impressions = Impression.where(student_id: student.id, assignment_id: id)
    else
      impressions = Impression.where(assignment_id: id)
    end
    0.5 * impressions.reduce(0.0) {|sum, i| sum + (i.positive ? 1 : -1)}
  end
end
