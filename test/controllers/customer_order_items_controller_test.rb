require 'test_helper'

class CustomerOrderItemsControllerTest < ActionController::TestCase
  setup do
    @customer_order_item = customer_order_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customer_order_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer_order_item" do
    assert_difference('CustomerOrderItem.count') do
      post :create, customer_order_item: { customer_note: @customer_order_item.customer_note, customer_order_id: @customer_order_item.customer_order_id, is_menu_item_ready: @customer_order_item.is_menu_item_ready, kitchenstaff_note: @customer_order_item.kitchenstaff_note, menu_item_id: @customer_order_item.menu_item_id, waitstaff_note: @customer_order_item.waitstaff_note }
    end

    assert_redirected_to customer_order_item_path(assigns(:customer_order_item))
  end

  test "should show customer_order_item" do
    get :show, id: @customer_order_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer_order_item
    assert_response :success
  end

  test "should update customer_order_item" do
    patch :update, id: @customer_order_item, customer_order_item: { customer_note: @customer_order_item.customer_note, customer_order_id: @customer_order_item.customer_order_id, is_menu_item_ready: @customer_order_item.is_menu_item_ready, kitchenstaff_note: @customer_order_item.kitchenstaff_note, menu_item_id: @customer_order_item.menu_item_id, waitstaff_note: @customer_order_item.waitstaff_note }
    assert_redirected_to customer_order_item_path(assigns(:customer_order_item))
  end

  test "should destroy customer_order_item" do
    assert_difference('CustomerOrderItem.count', -1) do
      delete :destroy, id: @customer_order_item
    end

    assert_redirected_to customer_order_items_path
  end
end
