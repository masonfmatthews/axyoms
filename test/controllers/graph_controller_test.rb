require 'test_helper'

class GraphControllerTest < ActionController::TestCase

  def setup
    @base_title = "Axyoms"
    set_up_user
  end

  test "should get packed_graph" do
    get :packed_graph
    assert_response :success
    assert_select "svg", count: 1
    assert_select "title", "#{@base_title} | Browse"
    #TODO: the two tests below fail, as they're rendered after the page loads.
    # assert_select ".node", count: 4
    # assert_select ".link", count: 1
  end

end
