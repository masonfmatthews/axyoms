require 'test_helper'

class GraphLayoutTest < ActionDispatch::IntegrationTest
  def setup
    set_up_user
  end

  test "graph links" do
    get root_path
    assert_template 'graph/packed_graph'
    assert_select "a[href=?]", root_path, count: 1
  end
end
