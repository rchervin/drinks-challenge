require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test 'should get home page' do
    get root_path
    assert :success
  end
end
