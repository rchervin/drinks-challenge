require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test 'should get home page' do
    get 'home'
    assert :success
  end
end
