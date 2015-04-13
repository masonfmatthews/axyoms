class GraphCache < ActiveRecord::Base
  serialize :unit_id_cache
  serialize :parentage_depth_cache
  serialize :precedence_depth_cache
  serialize :parentage_structure_cache
  serialize :precedence_link_cache
  serialize :all_link_cache

  def self.get
    last || create!
  end

  def graph
    @graph ||= Graph.new(Concept.all)
  end

  def cache_everything!
    cache_unit_ids!
    cache_parentage_depths!
    cache_precedence_depths!
    cache_parentage_structure!
    cache_precedence_links!
    cache_all_links!
    true
  end

  def unit_ids
    unit_id_cache || cache_unit_ids!
  end

  def cache_unit_ids!
    self.unit_id_cache = Hash.new([])
    graph.nodes.each do |c|
      self.unit_id_cache[c.uuid] = c.unit_ids
    end
    save!
    unit_id_cache
  end

  def parentage_depths
    parentage_depth_cache || cache_parentage_depths!
  end

  def cache_parentage_depths!
    self.parentage_depth_cache = Hash.new()
    graph.nodes.each do |c|
      self.parentage_depth_cache[c.uuid] = graph.parentage_depth(c)
    end
    save!
    parentage_depth_cache
  end

  def precedence_depths
    precedence_depth_cache || cache_precedence_depths!
  end

  def cache_precedence_depths!
    self.precedence_depth_cache = Hash.new()
    graph.nodes.each do |c|
      self.precedence_depth_cache[c.uuid] = graph.precedence_depth(c)
    end
    save!
    precedence_depth_cache
  end

  def parentage_structure
    parentage_structure_cache || cache_parentage_structure!
  end

  def cache_parentage_structure!
    self.parentage_structure_cache = graph.parentage_structure
    save!
    parentage_structure_cache
  end

  def precedence_links
    precedence_link_cache || cache_precedence_links!
  end

  def cache_precedence_links!
    self.precedence_link_cache = graph.precedence_links
    save!
    precedence_link_cache
  end

  def all_links
    all_link_cache || cache_all_links!
  end

  def cache_all_links!
    self.all_link_cache = graph.all_links
    save!
    all_link_cache
  end
end
