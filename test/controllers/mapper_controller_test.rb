require 'test_helper'

class MapperControllerTest < ActionController::TestCase

  def setup
    @base_title = "Mental Mapper"
    set_up_user
  end

  test "should get packed_graph" do
    get :packed_graph
    assert_response :success
    assert_select "title", "#{@base_title} | Browse"
  end

  test "d3 graph should display" do
    Concept.destroy_all
    graph_importer = GraphImporter.new(Graph.new)
    graph_importer.import_new_nodes(%q{Software Development // A
 Agile // A
 Computational Thinking // A
Source Control // A
})
    graph_importer.import_new_relationships("Software Development -> Source Control")
    get :packed_graph
    assert_select "svg", count: 1
    #TODO: the two tests below fail, as they're rendered after the page loads.
    # assert_select ".node", count: 4
    # assert_select ".link", count: 1
  end

end
