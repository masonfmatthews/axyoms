class GraphPresenter
  def initialize(graph_object)
    @graph = graph_object
  end

  #TODO: Test this
  #TODO: Ugh, it's so ugly.  Make it an object/many objects?
  def packed_graph_json
    # 5 sec
    ancestry = @graph.ancestry_structure
    depth_counts = Hash.new(0)
    ancestry.each do |c|
      depth_counts[c[:precedence_depth]] += 1
    end

    max_depth = depth_counts.keys.max || 0
    max_breadth = depth_counts.values.max || 0

    # No time
    depth_indices = Hash.new(0)
    uuid_x = Hash.new
    uuid_y = Hash.new
    ancestry.each do |c|
      depth = c[:precedence_depth]
      uuid_x[c[:uuid]] = c[:x_center] = (depth.to_f + 0.5)/(max_depth+1)
      uuid_y[c[:uuid]] = c[:y_center] = (depth_indices[depth].to_f + 0.5)/depth_counts[depth]
      depth_indices[depth] += 1
    end

    # 1 sec
    subsequence = @graph.subsequence_structure.map do |l|
      {source: {uuid: l[:source].uuid,
                x: uuid_x[l[:source].uuid],
                y: uuid_y[l[:source].uuid]},
       target: {uuid: l[:target].uuid,
                x: uuid_x[l[:target].uuid],
                y: uuid_y[l[:target].uuid]}
      }
    end

    # No time
    {nodes: ancestry, links: subsequence,
      x_count: max_depth+1, y_count: max_breadth}.to_json.html_safe
  end


  def force_graph_json
    indices = {}
    nodes = []
    @graph.nodes.each_with_index do |c, i|
      indices[c.uuid] = i
      nodes << {uuid: c.uuid, name: c.name,
        depth: @graph.parentage_depth(c), theory: c.theory.blank?,
        unit_ids: c.unit_ids}
    end

    links = @graph.all_link_structure.map do |l|
      {source: indices[l[:source].uuid], target: indices[l[:target].uuid]}
    end

    {nodes: nodes, links: links}.to_json.html_safe
  end
end
