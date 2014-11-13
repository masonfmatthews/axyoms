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

  def create_concept(attr)
    new_concept = Concept.create!(attr)
    concepts << new_concept
    new_concept
  end

  def create_relationship_by_names(source, target, association)
    source_concept = Concept.where(name: source).first
    target_concept = Concept.where(name: target).first
    unless concepts.include?(source_concept) && concepts.include?(target_concept)
      raise "Concepts not present in graph."
    end
    source_concept.send(association) << target_concept
  end
end
