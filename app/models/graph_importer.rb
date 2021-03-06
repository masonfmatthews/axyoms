class GraphImporter
  include Neo4jTransaction
  attr_accessor :graph

  def initialize(graph_object = Graph.new(Concept.all))
    @graph = graph_object
  end

  # Spaces at the beginning of a line in node_text imply that the
  #   node is a child of the most recent line with one less space of
  #   indentation.
  # A * at the beginning of a stripped line in node_text implies
  #   that the node is an implementation of its parent.
  def import_new_nodes(node_text)
    neo4j_transaction do
      stack = []
      node_text.each_line do |line|
        next if line.blank?
        depth = line[/\A */].size

        raise "Indentation too rapid on '#{line}'" if depth > stack.length + 1

        clauses = line.strip.split(' // ')

        implementation = false
        if clauses[0].starts_with?("* ")
          clauses[0] = clauses[0][2..-1]
          implementation = true
        end
        
        stack[depth] = @graph.create_node(name: clauses[0],
          description: clauses[1], is_implementation: implementation)
        if depth > 0
          stack[depth-1].child_concepts << stack[depth]
        end
      end
    end
  end


  def import_new_relationships(text)
    neo4j_transaction do
      text.each_line do |line|
        next if line.blank? || line.strip.blank?
        clauses = line.strip.split(' -> ')
        graph.create_relationship_by_names(clauses[0], clauses[1])
      end
    end
  end
end
