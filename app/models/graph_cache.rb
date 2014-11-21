class GraphCache < ActiveRecord::Base
  serialize :unit_ids

  def graph
    @graph ||= Graph.new(Concept.all)
  end

  def cache_unit_ids
    self.unit_ids = {}
    graph.nodes.each do |c|
      self.unit_ids[c.uuid] = c.unit_ids
    end
    save!
  end

  def self.get_cache(g)
    GraphCache.first || GraphCache.create!
  end
end
