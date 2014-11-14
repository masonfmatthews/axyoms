class GraphPresenter
  def initialize(graph_object)
    @graph = graph_object
  end

  #TODO: Test this
  #TODO: Ugh, it's so ugly.  Make it an object/many objects?
  def concept_d3_json
    ancestry = @graph.ancestry_structure
    depth_counts = Hash.new(0)
    ancestry.each do |c|
      depth_counts[c[:precedence_depth]] += 1
    end
    max_depth = depth_counts.keys.max
    max_breadth = depth_counts.values.max

    depth_indices = Hash.new(0)
    uuid_x = Hash.new
    uuid_y = Hash.new
    ancestry.each do |c|
      depth = c[:precedence_depth]
      uuid_x[c[:uuid]] = c[:x_center] = (depth.to_f + 0.5)/(max_depth+1)
      uuid_y[c[:uuid]] = c[:y_center] = (depth_indices[depth].to_f + 0.5)/depth_counts[depth]
      depth_indices[depth] += 1
    end

    subsequence = @graph.subsequence_structure.map do |l|
      {source: {uuid: l[:source].uuid,
                x: uuid_x[l[:source].uuid],
                y: uuid_y[l[:source].uuid]},
       target: {uuid: l[:target].uuid,
                x: uuid_x[l[:target].uuid],
                y: uuid_y[l[:target].uuid]}
      }
    end

    {nodes: ancestry, links: subsequence,
      x_count: max_depth+1, y_count: max_breadth}.to_json.html_safe
  end
end