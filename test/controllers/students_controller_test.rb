require 'test_helper'

class StudentsControllerTest < ActionController::TestCase
  def setup
    set_up_student
    set_up_user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:students)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create student" do
    assert_difference('Student.count') do
      post :create, student: { email: @student.email + "com", name: @student.name }
    end

    assert_redirected_to students_path
    assert_not flash.nil?
  end

  test "should fail to create student with duplicate email" do
    assert_no_difference('Student.count') do
      post :create, student: { email: @student.email, name: @student.name }
    end

    assert_template "students/new"
    assert_select "div#error_explanation"
    assert_select "div.field_with_errors"
  end

  test "should get edit" do
    get :edit, id: @student
    assert_response :success
  end

  test "should update student" do
    patch :update, id: @student, student: { email: @student.email, name: @student.name }
    assert_redirected_to students_path
  end

  test "should destroy student" do
    assert_difference('Student.count', -1) do
      delete :destroy, id: @student
    end

    assert_redirected_to students_path
  end
end
