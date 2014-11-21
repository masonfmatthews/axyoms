class GraphCache < ActiveRecord::Base
  serialize :unit_ids
  serialize :parentage_depths
  serialize :precedence_depths
  serialize :parentage_structure
  serialize :precedence_links
  serialize :all_links

  def graph
    @graph ||= Graph.new(Concept.all)
  end

  def cache_everything
    cache_unit_ids
    cache_parentage_depths
    cache_precedence_depths
    cache_parentage_structure
    cache_precedence_links
    cache_all_links
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

  def cache_parentage_structure
    self.parentage_structure = graph.parentage_structure
    save!
  end

  def cache_precedence_links
    self.precedence_links = graph.precedence_links
    save!
  end

  def cache_all_links
    self.all_links = graph.all_links
    save!
  end

  def self.get_cache
    GraphCache.first || GraphCache.create!
  end
end
