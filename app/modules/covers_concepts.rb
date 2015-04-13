module CoversConcepts

  def concept_count
    coverages.length
  end

  def concept_uuids
    @cached_concept_uuids ||= coverages.map &:concept_uuid
  end

  def concepts
    @cached_concepts ||= Concept.find(concept_uuids)
  end

  def set_coverage(uuids)
    self.coverages = []
    unless uuids.blank?
      uuids.each do |uuid|
        coverages.build(concept_uuid: uuid)
      end
    end
  end

  def coverage_hash
    hash = Hash.new
    coverages.each do |c|
      hash[c.concept_uuid] = true
    end
    hash
  end
end
