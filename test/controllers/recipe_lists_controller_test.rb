require "test_helper"

class RecipeListsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get recipe_lists_index_url
    assert_response :success
  end

  test "should get show" do
    get recipe_lists_show_url
    assert_response :success
  end

  test "should get new" do
    get recipe_lists_new_url
    assert_response :success
  end

  test "should get create" do
    get recipe_lists_create_url
    assert_response :success
  end
end
