module IsScored
  def average_score(filters = nil)
    pertinent_scores = scores.where(filters)
    return nil if pertinent_scores.blank?
    (pertinent_scores.reduce(0.0) {|sum, s| sum + s.score})/(pertinent_scores.count)
  end
end
