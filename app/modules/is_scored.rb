module IsScored
  IMPRESSION_FACTOR = 0.5

  def average_score(student = nil)
    pertinent_scores = (student ? scores.where(student_id: student.id) : scores)
    return nil if pertinent_scores.blank?
    impression_score(student) + (pertinent_scores.reduce(0.0) {|sum, s| sum + s.score})/(pertinent_scores.count)
  end

  def impression_score(student)
    pertinent_impressions = student ? impressions.where(student_id: student.id) : impressions
    IMPRESSION_FACTOR * impressions.reduce(0.0) {|sum, i| sum + (i.positive ? 1 : -1)}
  end
end
