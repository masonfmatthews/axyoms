require 'test_helper'

class GraphCacheTest < ActiveSupport::TestCase
  def setup
    units(:one).add_concept(concepts(:one))
    @graph_cache = GraphCache.get_cache(nil)
  end

  def test_cache_unit_ids
    @graph_cache.cache_unit_ids
    assert_equal @graph_cache.unit_ids[concepts(:one).uuid], [units(:one).id]
    assert_equal @graph_cache.unit_ids[concepts(:two).uuid], []
  end

  def test_cache_parentage_depths
    @graph_cache.cache_parentage_depths
    assert_equal @graph_cache.parentage_depths[concepts(:one).uuid], 0
    assert_equal @graph_cache.parentage_depths[concepts(:three).uuid], 2
  end

  def test_cache_precedence_depths
    @graph_cache.cache_precedence_depths
    assert_equal @graph_cache.precedence_depths[concepts(:one).uuid], 0
    assert_equal @graph_cache.precedence_depths[concepts(:three).uuid], 0
    assert_equal @graph_cache.precedence_depths[concepts(:four).uuid], 1
  end


end
