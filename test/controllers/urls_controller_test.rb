require 'test_helper'

class UrlsControllerTest < ActionController::TestCase
  setup do
    @url = urls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:urls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create url" do
    assert_difference('Url.count') do
      post :create, url: { active: @url.active, full_url: @url.full_url, short_url: @url.short_url }
    end

    assert_redirected_to url_path(assigns(:url))
  end

    assert_redirected_to urls_path
  end
end
