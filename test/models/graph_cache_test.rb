require 'test_helper'

class GraphCacheTest < ActiveSupport::TestCase
  def setup
    units(:one).add_concept(concepts(:one))
    @graph_cache = GraphCache.get_cache(nil)
  end

  def test_cache_unit_ids
    @graph_cache.cache_unit_ids
    assert_equal @graph_cache.unit_ids[concepts(:one).uuid], [units(:one).id]
  end
end
