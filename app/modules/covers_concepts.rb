module CoversConcepts
  def concept_uuids
    coverages.map &:concept_uuid
  end

  def concept_count
    coverages.length
  end

  def concepts
    Concept.find(concept_uuids)
  end

  def add_concept(concept)
    coverages.build(concept_uuid: concept.uuid)
    save!
  end

  def new_coverage(uuids)
    uuids.each do |uuid|
      coverages.build(concept_uuid: uuid)
    end
    save!
  end

  def replace_coverage(uuids)
    self.coverages = []
    new_coverage(uuids)
  end

  def coverage_hash
    hash = Hash.new
    coverages.each do |c|
      hash[c.concept_uuid] = true
    end
    hash
  end
end
