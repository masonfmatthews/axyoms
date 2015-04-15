module IsScored
  def average_score(filters = nil)
    pertinent_scores = scores.where(filters)
    return nil if pertinent_scores.blank?
    (pertinent_scores.reduce(0.0) {|sum, s| sum + s.score})/(pertinent_scores.count)
  end

  def last_score(filters = nil)
    pertinent_scores = scores.where(filters)
    pertinent_scores.blank? ? nil : pertinent_scores.last.score
  end
end
