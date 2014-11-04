class Concept
  include Neo4j::ActiveNode
  property :name
  property :description
  has_many :out, :children, model_class: :Concept, type: 'contains'
  has_many :in, :parents, model_class: :Concept, origin: :children
end
