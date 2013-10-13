require 'test_helper'

class EmployeeTablesControllerTest < ActionController::TestCase
  setup do
    @employee_table = employee_tables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:employee_tables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create employee_table" do
    assert_difference('EmployeeTable.count') do
      post :create, employee_table: { assign_date: @employee_table.assign_date, employee_id: @employee_table.employee_id, table_id: @employee_table.table_id }
    end

    assert_redirected_to employee_table_path(assigns(:employee_table))
  end

  test "should show employee_table" do
    get :show, id: @employee_table
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @employee_table
    assert_response :success
  end

  test "should update employee_table" do
    patch :update, id: @employee_table, employee_table: { assign_date: @employee_table.assign_date, employee_id: @employee_table.employee_id, table_id: @employee_table.table_id }
    assert_redirected_to employee_table_path(assigns(:employee_table))
  end

  test "should destroy employee_table" do
    assert_difference('EmployeeTable.count', -1) do
      delete :destroy, id: @employee_table
    end

    assert_redirected_to employee_tables_path
  end
end
