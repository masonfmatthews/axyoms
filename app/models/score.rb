class Score < ActiveRecord::Base
  belongs_to :student
  belongs_to :assignment

  validates :student, presence: true
  validates :assignment, presence: true
  validates :score, presence: true
end
