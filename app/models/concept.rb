class Concept
  include Neo4j::ActiveNode
  property :name, type: String
  property :description, type: String
  property :updated_at, type: DateTime #Automatically set
  property :created_at, type: DateTime #Automatically set

  validates :name, presence: true
  index :name

  has_many :out, :subsequents, model_class: self, type: 'precedes'
  has_many :in, :precedents, model_class: self, origin: :subsequents

  has_many :out, :implementations, model_class: self, type: 'implements'
  has_one  :in, :theory, model_class: self, origin: :implementations

  has_many :out, :child_concepts, model_class: self, type: 'contains'
  has_one  :in, :parent_concepts, model_class: self, origin: :child_concepts

  def references
    Reference.where(concept_uuid: uuid).where.not(concept_uuid: nil)
  end
end
