require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "get index" do
    get users_path
    assert_response :success
  end
end
