class Concept
  include Neo4j::ActiveNode
  property :name, type: String
  property :description, type: String
  property :updated_at, type: DateTime #Automatically set
  property :created_at, type: DateTime #Automatically set

  validates :name, presence: true, uniqueness: true
  index :name

  has_many :out, :subsequents, model_class: self, type: 'precedes'
  has_many :in, :precedents, model_class: self, origin: :subsequents

  has_many :out, :implementations, model_class: self, type: 'implements'
  has_one  :in, :theory, model_class: self, origin: :implementations

  has_many :out, :child_concepts, model_class: self, type: 'contains'
  has_one  :in, :parent_concept, model_class: self, origin: :child_concepts

  def references
    Reference.where(concept_uuid: uuid).where.not(concept_uuid: nil)
  end

  def self.import_nodes(node_text)
    return_value = true
    begin
      tx = Neo4j::Transaction.new
      stack = []
      node_text.each_line do |line|
        next if line.blank?
        depth = line[/\A */].size
        
        raise "Indentation too rapid on '#{line}'" if depth > stack.length + 1

        matches = /\A(.*) \/\/ (.*)\z/.match(line.strip)
        stack[depth] = Concept.create!(name: matches[1], description: matches[2])
        if depth > 0
          stack[depth-1].child_concepts << stack[depth]
        end
      end
    rescue
      tx.failure
      return_value = false
    ensure
      tx.close
    end
  end

  def self.to_json
    return [
        { "id" => 1,
          "name" => "Software Development",
          "xOffset" => 100,
          "yOffset" => 100,
          "children" => [
              { "id" => 4,
                "name" => "Agile" },
              { "id" => 5,
                "name" => "Computational Thinking" }
          ]
        },
        { "id" => 2,
          "name" => "Source Control",
          "xOffset" => 300,
          "yOffset" => 100
        },
        { "id" => 3,
          "name" => "OOP",
          "xOffset" => 500,
          "yOffset" => 100
        },
        { "id" => 6,
          "name" => "Procedural Languages",
          "xOffset" => 700,
          "yOffset" => 100,
          "children" => [
              { "id" => 7,
                "name" => "Control Flow",
                "children" => [
                  { "id" => 9,
                    "name" => "Agile" },
                  { "id" => 10,
                    "name" => "Computational Thinking" }
                ]
              },
              { "id" => 11,
                "name" => "Call Stack"
              },
              { "id" => 12,
                "name" => "Functions"
              },
              { "id" => 8,
                "name" => "Scope" }
          ]
        }
    ].to_json

  end
end
