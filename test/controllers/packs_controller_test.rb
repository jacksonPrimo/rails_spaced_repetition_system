require "test_helper"

class PacksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get packs_index_url
    assert_response :success
  end

  test "should get show" do
    get packs_show_url
    assert_response :success
  end

  test "should get new" do
    get packs_new_url
    assert_response :success
  end

  test "should get edit" do
    get packs_edit_url
    assert_response :success
  end

  test "should get create" do
    get packs_create_url
    assert_response :success
  end

  test "should get update" do
    get packs_update_url
    assert_response :success
  end

  test "should get destroy" do
    get packs_destroy_url
    assert_response :success
  end
end
