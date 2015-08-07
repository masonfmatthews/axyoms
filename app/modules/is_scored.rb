module IsScored
  IMPRESSION_FACTOR = 0.5

  def average_score(student = nil)
    pertinent_scores = (student ? scores.where(student_id: student.id) : scores)
    return nil if pertinent_scores.blank?
    (impression_score(student) + pertinent_scores.reduce(0.0) {|sum, s| sum + s.score})/(pertinent_scores.count)
  end

  def impression_score(student = nil)
    pertinent_impressions = student ? impressions.where(student_id: student.id) : impressions
    IMPRESSION_FACTOR * pertinent_impressions.reduce(0.0) {|sum, i| sum + (i.positive ? 1 : -1)}
  end

  def positive_impressions(concept: nil, assignment: nil)
    results = impressions.where(positive: true)
    results = results.where(concept_uuid: concept.uuid) if concept
    results = results.where(assignment_id: assignment.id) if assignment
    results
  end

  def negative_impressions(concept: nil, assignment: nil)
    results = impressions.where(positive: false)
    results = results.where(concept_uuid: concept.uuid) if concept
    results = results.where(assignment_id: assignment.id) if assignment
    results
  end
end
