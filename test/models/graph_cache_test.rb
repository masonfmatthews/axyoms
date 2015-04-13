require 'test_helper'

class GraphCacheTest < ActiveSupport::TestCase
  def setup
    units(:one).set_coverage([concepts(:one).uuid])
    units(:one).save!
    @graph_cache = GraphCache.get
    @graph_cache.cache_everything!
  end

  def test_cache_parentage_depths
    assert_equal @graph_cache.parentage_depths[concepts(:one).uuid], 0
    assert_equal @graph_cache.parentage_depths[concepts(:three).uuid], 2
  end

  def test_cache_precedence_depths
    assert_equal @graph_cache.precedence_depths[concepts(:one).uuid], 0
    assert_equal @graph_cache.precedence_depths[concepts(:three).uuid], 0
    assert_equal @graph_cache.precedence_depths[concepts(:four).uuid], 1
  end

  def test_cache_links
    assert @graph_cache.precedence_links.include?(
      {source: concepts(:one).uuid, target: concepts(:four).uuid})
    assert !@graph_cache.precedence_links.include?(
      {source: concepts(:one).uuid, target: concepts(:two).uuid})
    assert @graph_cache.all_links.include?(
      {source: concepts(:one).uuid, target: concepts(:two).uuid})
  end
end
