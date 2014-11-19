class GraphImporter
  attr_accessor :graph

  def initialize(graph_object = Graph.new)
    @graph = graph_object
  end

  # TODO: Break these two methods out in the spirit of POODR.
  def import_new_nodes(node_text)
    begin
      tx = Neo4j::Transaction.new
      stack = []
      node_text.each_line do |line|
        next if line.blank?
        depth = line[/\A */].size

        raise "Indentation too rapid on '#{line}'" if depth > stack.length + 1

        clauses = line.strip.split(' // ')
        if depth > 0 && clauses[0].starts_with?("* ")
          stack[depth] = @graph.create_concept(name: clauses[0][2..-1], description: clauses[1])
          stack[depth-1].implementations << stack[depth]
        else
          stack[depth] = @graph.create_concept(name: clauses[0], description: clauses[1])
          if depth > 0
            stack[depth-1].child_concepts << stack[depth]
          end
        end
      end
    rescue
      tx.failure
      raise
    ensure
      tx.close
    end
  end

  def import_new_relationships(text, association_name = "subsequents")
    text.each_line do |line|
      next if line.blank? || line.strip.blank?
      clauses = line.strip.split(' -> ')
      graph.create_relationship_by_names(clauses[0], clauses[1], association_name)
    end
  end
end
