class Graph
  attr_accessor :concepts

  def initialize(concept_array = [])
    @concepts = concept_array.to_a
  end

  def destroy
    concepts.each &:destroy
    concepts = []
  end

  # TODO: Write query with Cypher
  def root_concepts
    @concepts.select {|c| c.parent_concept.blank? && c.theory.blank? }
  end

  def ancestry_structure
    root_concepts.map(&:to_hash)
  end

  def subsequence_structure
    root_concepts.map(&:subsequence_structure).flatten
  end

  def all_link_structure
    concepts.map(&:all_links).flatten
  end

  def create_concept(attr)
    new_concept = Concept.create!(attr)
    concepts << new_concept
    new_concept
  end

  def create_relationship_by_names(source, target, association)
    source_concept = Concept.where(name: source).first
    target_concept = Concept.where(name: target).first
    raise "'#{source}' not present in graph." unless concepts.include?(source_concept)
    raise "'#{target}' not present in graph." unless concepts.include?(target_concept)
    source_concept.send(association) << target_concept
  end
end
