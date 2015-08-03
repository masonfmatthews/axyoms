class Assignment < ActiveRecord::Base
  include CoversConcepts
  has_many :coverages, dependent: :destroy,
      foreign_key: 'assignment_id', class_name: "AssignmentCoverage"

  include IsScored
  has_many :scores, dependent: :restrict_with_error

  has_many :impressions, dependent: :restrict_with_error

  validates :name, presence: true
  validates :uri, presence: true, format: {with: /\Ahttps?:\/\//, message: "must start with http:// or https://"}

  default_scope { order(:created_at) }
end
