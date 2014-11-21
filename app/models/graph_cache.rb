class GraphCache < ActiveRecord::Base
  serialize :unit_ids
  serialize :parentage_depths
  serialize :precedence_depths

  def graph
    @graph ||= Graph.new(Concept.all)
  end

  def cache_unit_ids
    self.unit_ids = Hash.new([])
    graph.nodes.each do |c|
      self.unit_ids[c.uuid] = c.unit_ids
    end
    save!
  end

  def cache_parentage_depths
    self.parentage_depths = Hash.new()
    graph.nodes.each do |c|
      self.parentage_depths[c.uuid] = graph.parentage_depth(c)
    end
    save!
  end

  def cache_precedence_depths
    self.precedence_depths = Hash.new()
    graph.nodes.each do |c|
      self.precedence_depths[c.uuid] = graph.precedence_depth(c)
    end
    save!
  end

  def self.get_cache(g)
    GraphCache.first || GraphCache.create!
  end
end
