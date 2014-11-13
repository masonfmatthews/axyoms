class Graph
  attr_accessor :concepts

  def initialize(concept_array = Concept.all)
    @concepts = concept_array
  end

  def destroy
    concepts.destroy_all
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

end
