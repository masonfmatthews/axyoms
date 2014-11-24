class GraphPresenter
  attr_accessor :graph, :graph_cache
  def initialize(g)
    @graph = g
    @graph_cache = GraphCache.get_cache(g)
  end

  #TODO: Test this
  #TODO: Ugh, it's so ugly.  Make it an object/many objects?
  def packed_graph_json
    ancestry = graph_cache.parentage_structure
    depth_counts = Hash.new(0)
    ancestry.each do |c|
      depth_counts[graph_cache.precedence_depths[c[:uuid]]] += 1
    end

    max_depth = depth_counts.keys.max || 0
    max_breadth = depth_counts.values.max || 0

    depth_indices = Hash.new(0)
    uuid_x = Hash.new
    uuid_y = Hash.new
    ancestry.each do |c|
      depth = graph_cache.precedence_depths[c[:uuid]]
      uuid_x[c[:uuid]] = c[:x_center] = (depth.to_f + 0.5)/(max_depth+1)
      uuid_y[c[:uuid]] = c[:y_center] = (depth_indices[depth].to_f + 0.5)/depth_counts[depth]
      depth_indices[depth] += 1
    end

    # 1 sec
    subsequence = graph_cache.precedence_links.map do |l|
      {source: {uuid: l[:source],
                x: uuid_x[l[:source]],
                y: uuid_y[l[:source]]},
       target: {uuid: l[:target],
                x: uuid_x[l[:target]],
                y: uuid_y[l[:target]]}
      }
    end

    # No time
    {nodes: ancestry, links: subsequence,
      x_count: max_depth+1, y_count: max_breadth}.to_json.html_safe
  end


  def force_graph_json
    indices = {}
    nodes = []
    graph.nodes.each_with_index do |c, i|
      indices[c.uuid] = i
      nodes << {uuid: c.uuid,
        name: c.name,
        depth: graph_cache.parentage_depths[c.uuid],
        unit_ids: graph_cache.unit_ids[c.uuid]}
    end

    links = graph_cache.all_links.map do |l|
      {source: indices[l[:source]], target: indices[l[:target]]}
    end

    {nodes: nodes, links: links}.to_json.html_safe
  end
end
