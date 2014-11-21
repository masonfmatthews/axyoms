class Graph
  attr_accessor :relation, :nodes

  def initialize(rel)
    @relation = rel
    @nodes = rel.to_a
    @parentage_depths = {}
    @precedence_depths = {}
  end

  def destroy
    nodes.each &:destroy
    nodes = relation.to_a
    @roots = nil
  end

  # TODO: Write query with Cypher?
  def root_ancestor_nodes
    @roots ||= nodes.select {|c| c.root_ancestor? }
  end

  def parentage_structure
    root_ancestor_nodes.map {|r| r.children_hash}
  end

  def precedence_links
    root_ancestor_nodes.map(&:precedence_links).flatten
  end

  def all_links
    nodes.map(&:all_links).flatten
  end

  def parentage_depth(node)
    @parentage_depths[node] ||= node.parentage_depth(self)
  end

  def precedence_depth(node)
    @precedence_depths[node] ||= node.precedence_depth(self)
  end

  def create_node(attr)
    #TODO: I don't like the dependence on the name Concept
    new_node = Concept.create!(attr)
    nodes << new_node
    new_node
  end

  def create_relationship_by_names(source, target)
    raise "'#{source}' not present in graph." unless source_node = relation.where(name: source).first
    raise "'#{target}' not present in graph." unless target_node = relation.where(name: target).first
    source_node.create_relationship_with(target_node)
  end
end
