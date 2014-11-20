class Concept
  include Neo4j::ActiveNode
  property :name, type: String
  property :description, type: String
  property :updated_at, type: DateTime #Automatically set
  property :created_at, type: DateTime #Automatically set

  validates :name, presence: true, uniqueness: true
  index :name

  #TODO: Validate assumption of no loops.
  has_many :out, :subsequents, model_class: self, type: 'precedes'
  has_many :in, :precedents, model_class: self, origin: :subsequents

  has_many :out, :implementations, model_class: self, type: 'implements'
  has_one  :in, :theory, model_class: self, origin: :implementations

  has_many :out, :child_concepts, model_class: self, type: 'contains'
  has_one  :in, :parent_concept, model_class: self, origin: :child_concepts

  def references
    Reference.where(concept_uuid: uuid).where.not(concept_uuid: nil)
  end

  def unit_coverages
    UnitCoverage.where(concept_uuid: uuid)
  end

  def unit_ids
    unit_coverages.map &:unit_id
  end

  def units
    Unit.find(unit_ids)
  end

  def to_hash
    {uuid: uuid,
     name: name,
     description: description,
     precedence_depth: precedence_depth,
     children: child_concepts.map(&:to_hash),
     unit_ids: unit_ids}
  end

  # TODO: recursive and potentially SLOW
  def precedence_depth
    return 0 if precedents.blank?
    depths = precedents.map(&:precedence_depth)
    depths.max + 1
  end

  def parentage_depth
    return 0 if parent_concept.blank?
    parent_concept.parentage_depth + 1
  end

  def subsequence_structure
    subsequents.map do |s|
      {source: self, target: s}
    end
  end

  def all_links
    (subsequents.to_a + implementations.to_a + child_concepts.to_a).map do |s|
      {source: self, target: s}
    end
  end
end
