class Concept
  include Neo4j::ActiveNode
  property :name, type: String, index: :exact
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

  def children_hash
    {uuid: uuid,
     name: name,
     description: description,
     children: child_concepts.map {|c| c.children_hash}}
  end

  def precedence_depth(graph)
    if precedents.blank?
      0
    else
      depths = precedents.map {|p| graph.precedence_depth(p)}
      depths.max + 1
    end
  end

  def parentage_depth(graph)
    parent_concept.blank? ? 0 : graph.parentage_depth(parent_concept) + 1
  end

  def link_hash(other_concept)
    {source: self.uuid, target: other_concept.uuid}
  end

  def precedence_links
    subsequents.map {|s| link_hash(s)}
  end

  def parentage_links
    child_concepts.map {|s| link_hash(s)}
  end

  def implementation_links
    implementations.map {|s| link_hash(s)}
  end

  def all_links
    precedence_links + parentage_links + implementation_links
  end
end
