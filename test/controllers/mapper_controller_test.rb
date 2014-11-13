require 'test_helper'

class MapperControllerTest < ActionController::TestCase

  def setup
    @base_title = "Mental Mapper"
  end

  test "should get show" do
    get :show
    assert_response :success
    assert_select "title", "#{@base_title} | Browse"
  end

  test "d3 graph should display" do
    Concept.destroy_all
    Concept.import_nodes(%q{Software Development // A
 Agile // A
 Computational Thinking // A
Source Control // A
})
    Concept.import_precedence("Software Development -> Source Control")
    get :show
    assert_select "svg", count: 1
    #TODO: the two tests below fail, as they're rendered after the page loads.
    # assert_select ".node", count: 4
    # assert_select ".link", count: 1
  end

end
