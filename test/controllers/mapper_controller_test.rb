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

end
